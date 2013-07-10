source 'https://rubygems.org'

# Specify your gem's dependencies in rendo.gemspec
gemspec

# specify these here so I can use github version of guard-minitest
# plus its pretty specific to my own workflow, no need to make everyone
# install it.
group :test do
  gem "guard"
  gem "guard-minitest", github: 'guard/guard-minitest', branch: 'master'
  gem "terminal-notifier-guard"
end
