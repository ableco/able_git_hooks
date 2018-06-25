#!/usr/bin/env ruby

require "rubocop"

staged_files = `git diff --cached --name-only --diff-filter=ACM`.split
base_command = "bundle exec rubocop -RP -c config/rubocop.yml --force-exclusion"

staged_files.each do |file|
  `#{base_command} --stdin "#{file}" < <(git show :"$#{file}")`
end
