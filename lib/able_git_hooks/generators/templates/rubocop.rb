#!/usr/bin/env ruby

require "rubocop"
require "shellwords"

staged_files = `git diff -z --staged --name-only --diff-filter=ACM`.split("\u0000")

exit 0 if staged_files.empty?

config_store = RuboCop::ConfigStore.new
target_files = RuboCop::TargetFinder.new(config_store).find(staged_files)

target_files.each do |target_path|
  relative = target_path.sub("#{Dir.pwd}/", "")
  command  = %Q(rubocop -R -c config/rubocop.yml --force-exclusion --stdin "#{relative}" < <(git show :"#{relative}"))
  command  = Shellwords.escape(command)

  exit 1 unless system("bash -c #{command}")
end
