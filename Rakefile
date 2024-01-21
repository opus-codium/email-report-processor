# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'github_changelog_generator/task'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:features)

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.header = <<~HEADER.chomp
    # Changelog

    All notable changes to this project will be documented in this file.

    The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
    and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
  HEADER
  config.user = 'opus-codium'
  config.project = 'email-report-processor'
  config.issues = false
  config.exclude_labels = %w[dependencies skip-changelog]
  require 'email_report_processor/version'
  config.future_release = "v#{EmailReportProcessor::VERSION}"
end

task test: %i[spec features]

task default: :test
