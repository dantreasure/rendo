# require everything in lib
Dir.glob(File.join(File.dirname(__FILE__), 'rendo/**/*.rb')) do |file|
  to_require = file.match(%r{lib/(rendo/.*)\.rb$})[1]
  require to_require
end

module Rendo

end
