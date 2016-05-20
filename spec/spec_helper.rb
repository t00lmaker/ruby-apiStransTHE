require 'rspec'

require File.join(File.join(File.dirname(__FILE__), '..', 'lib', 'strans-client'))

Dir.glob(File.join(File.join(File.dirname(__FILE__), 'support'), '*.rb')).each do |file|
  require file
end
