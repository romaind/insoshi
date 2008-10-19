#!/usr/bin/env ruby

$VERBOSE = true

require "test/unit"
require "rss"

test_file = "#{File.dirname(__FILE__)}/test_*.rb"
case ARGV.first
when /\A--\z/
  ARGV.shift
when /\A-/, nil;
else
  test_file = ARGV.shift
end

$:.unshift(File.join(File.expand_path("."), "lib"))
$:.unshift(File.join(File.expand_path("."), "test"))
require 'test-unit-ext'

Dir.glob(test_file) do |file|
  require file
end

argv = ARGV.dup
unless argv.find {|opt| /\A(?:-v|--verbose=)/ =~ opt}
  argv << "--verbose=n"
end
unless argv.find {|opt| /\A--(?:no-)priority/ =~ opt}
  argv << "--priority"
end

RSS::AVAILABLE_PARSERS.each do |parser|
  puts "------------------------------------"
  puts "Using #{parser}"
  puts "------------------------------------"
  RSS::Parser.default_parser = parser
  break unless defined?(Test::Unit::AutoRunner)
  GC.start
  args = [File.dirname($0), argv.dup]
  if Test::Unit::AutoRunner.respond_to?(:standalone?)
    args.unshift(false)
  else
    args.unshift($0)
  end
  Test::Unit::AutoRunner.run(*args)
  puts
end
