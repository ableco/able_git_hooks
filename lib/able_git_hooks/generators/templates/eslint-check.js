#!/usr/bin/env node

"use strict";

/***
 * Description:
 *    Run prettier on the files are they are staged to be commit. Exit successfully
 * only if the file would be left unchanged by prettier.
 *
 * Steps:
 *
 *  1. List the sources files that are to be committed.
 *  2. Use git show :<path> to print the staged file to stdout.
 *  3. Pipe stdout to `prettier.check`.
 *
 ***/

const { promisify } = require("util");
let { exec } = require("child_process");
exec = promisify(exec);
const ESLintCLIEngine = require("eslint").CLIEngine;
const cli = new ESLintCLIEngine({});
const formatter = cli.getFormatter();


const getStagedFiles =
  "git diff --staged --name-only -z --diff-filter=ACMR";

const onlyJSFiles = filenames => {
  return filenames.filter(
    file => file.endsWith(".js") || file.endsWith(".jsx"),
  );
};

const splitFileNames = ret => {
  const fileNames = ret.stdout.substring(0, ret.stdout.length - 1);
  return fileNames.split("\u0000");
};

function and(x, y) {
  return x && y;
}

const reduceWithAnd = xs => {
  return xs.reduce(and, true);
};

const exit = success => {
  if (success) {
    process.exit(0);
  } else {
    process.exit(1);
  }
};

function lintFile(filepath) {
  return exec(`git show :${filepath}`).then(ret => {
    const report = cli.executeOnText(ret.stdout, filepath);
    if (report.errorCount > 0 || report.warningCount > 0) {
      const errorResults = ESLintCLIEngine.getErrorResults(report.results);
      console.log(formatter(errorResults));
    }
    return report.errorCount === 0 && report.warningCount === 0;
  });
}

function lintFiles(filepaths) {
  return Promise.all(filepaths.map(lintFile));
}

exec(getStagedFiles)
  .then(splitFileNames)
  .then(onlyJSFiles)
  .then(lintFiles)
  .then(reduceWithAnd)
  .then(exit);
