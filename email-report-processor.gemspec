# frozen_string_literal: true

require_relative 'lib/email_report_processor/version'

Gem::Specification.new do |spec|
  spec.name          = 'email-report-processor'
  spec.version       = EmailReportProcessor::VERSION
  spec.authors       = ['Romain Tartière']
  spec.email         = ['romain@blogreen.org']

  spec.summary       = 'Utilities to store e-mail reports in OpenSearch.'
  spec.homepage      = 'https://github.com/opus-codium/email-report-processor'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri']   = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'mail'
  spec.add_runtime_dependency 'rexml'
  spec.add_runtime_dependency 'rubyzip'
end
