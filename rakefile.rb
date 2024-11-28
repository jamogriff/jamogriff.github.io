require 'html-proofer'

task :test do
  sh 'bundle exec jekyll build'
  puts "Jekyll build complete"
  # Tests fail, but I don't really care
  sh 'bundle exec rspec'
  puts "RSpec test suite run complete"

  # Options for HtmlProofer test suite
  options = { :assume_extension => true,
              :http_status_ignore => [999] }
  HTMLProofer.check_directory('./_site', options).run
  puts "HtmlProofer test suite run complete"
end

task :test_html do
  sh 'bundle exec jekyll build'
  puts "Jekyll build complete"

  # Options for HtmlProofer test suite
  options = { :assume_extension => true,
              :http_status_ignore => [999] }
  HTMLProofer.check_directory('./_site', options).run
  puts "HtmlProofer test suite run complete"
end
