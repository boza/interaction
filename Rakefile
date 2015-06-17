require "bundler/gem_tasks"

require 'rake/testtask'

task default: :test

Rake::TestTask.new(:test) do |test|
  test.libs << "test" # here is the test_helper
  test.pattern = "test/**/*_test.rb"
end