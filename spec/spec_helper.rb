# Gems
require 'rspec'
require 'capybara/rspec'
require 'rack/jekyll'
require 'rack/test'
require 'launchy'
require 'yaml'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Capybara specific setup
  config.include Capybara::DSL # apparently need to explicitly require this
  Capybara.save_path = "tmp/capybara"

  # Custom selector for finding images
  Capybara.add_selector(:image) do
    xpath { |name| ".//img[contains(@src,\"/assets/images/#{name}\")]" }
  end

  Capybara.register_driver :selenium do |app|
    # configure Selenium to use Chrome
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  # configure Capybara to load website through rack-jekyll.
  # (force_build: true) builds site before tests are run, 
  # so tests are always run against current Jekyll build
  Capybara.app = Rack::Jekyll.new(force_build: true)

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  #config.warnings = true

end
