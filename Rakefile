require "bundler/gem_tasks"

task :test do
  $LOAD_PATH.unshift('lib', 'spec')
  Dir.glob('./spec/**/*_spec.rb') { |f| require f }
end

task :rendo do
  sh 'ruby -Ilib bin/rendo'
end
