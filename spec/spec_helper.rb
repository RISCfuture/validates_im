Bundler.require :default, :test

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'validates_im'

RSpec.configure do |config|
  
end
