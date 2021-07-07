source "https://rubygems.org"
gem "jekyll", "~> 3.4" # v 4.2 incompatible with hydeout theme

# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
# gem "github-pages", group: :jekyll_plugins
# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-theme-hydeout", "~>3.4"
  gem "github-pages"
  gem "jekyll-feed", "~> 0.12"
end

group :development, :test do
  gem "kramdown-parser-gfm" # added due to local build error
  gem "rake"
  gem "html-proofer"
  gem "rspec"
  gem "capybara"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
  gem "rack-jekyll" # serves Jekyll through Rack interface
  gem "launchy"
end

# UNCOMMENT BELOW IF DEVELOPING ON WINDOWS
#platforms :mingw, :x64_mingw, :mswin, :jruby do
  #gem "tzinfo", "~> 1.2"
  #gem "tzinfo-data"
#end

#gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
