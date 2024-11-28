require 'html-proofer'

task :test do
  sh 'bundle exec jekyll build'
  puts "Jekyll build complete"

  # Options for HtmlProofer test suite
  options = { :assume_extension => true,
              :http_status_ignore => [999] }
  HTMLProofer.check_directory('./_site', options).run
  puts "HtmlProofer test suite run complete"
end
