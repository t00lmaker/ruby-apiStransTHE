require 'json'
require 'strans-client'

Dir.glob(File.join(File.join(File.dirname(__FILE__), "..", "lib"), "**.rb")).each do |file|
  require file
end
