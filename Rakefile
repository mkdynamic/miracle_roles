require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('miracle_roles', '0.1.0') do |p|
  p.description    = "A dead simple roles plugin for Rails."
  p.url            = "http://github.com/mkdynamic/miracle_roles"
  p.author         = 'Mark Dodwell'
  p.email          = "http://twitter.com/madeofcode"
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
