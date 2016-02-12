# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4.
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Use documentation format when only running a single file
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # Only use new expectation syntax
  config.disable_monkey_patching!

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

end

