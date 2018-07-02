#!/usr/bin/env node

'use strict';

/***
 * Description:
 *   Run stylelint against the staged version of style files. If any errors are
 * found by stylelint, print them to standard output and return with a non-zero
 * exit code. Otherwise return successfully.
***/

const { promisify } = require('util');
let { exec } = require('child_process');
exec = promisify(exec);
const stylelint = require('stylelint');


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
  return exec(`git show :${filepath}`)
    .then(ret => stylelint.lint({ code: ret.stdout, codeFilename: filepath, formatter: 'verbose' }))
    .then(result => {
      if (!result.errored) {
        return true;
      } else {
        console.log(result.output);
        return false;
      }
    });
}

function lintFiles(filepaths) {
  return Promise.all(filepaths.map(lintFile));
}

exec(getStagedFiles)
  .then(splitFileNames)
  .then(onlyStyleFiles)
  .then(lintFiles)
  .then(reduceWithAnd)
  .then(exit);
