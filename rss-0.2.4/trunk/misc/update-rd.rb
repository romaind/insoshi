#!/usr/bin/env ruby

$KCODE = "utf8"

require 'nkf'
require 'rwiki/soap/driver'

def convert(src)
  NKF.nkf("-w", src)
end

def update_source(driver, src, name, page_name, log=nil)
  if src == driver.src(page_name)
    puts "#{name} doesn't need update"
    return
  end
  if log.nil?
    ENV["LANG"] = "C"
    if /Last Changed Rev: (\d+)/ =~ `svn info #{name}`
      log = "update to r#{$1}"
    end
  end
  driver.submit(page_name, src, nil, log)
  puts "committed #{name}"
end

def update_rd(driver, name, page_name=name, prefix=nil)
  prefix ||= "RSS Parser::"
  src = convert(File.read(name))
  src = yield(src, prefix) if block_given?
  page_name = "#{prefix}#{page_name}"
  update_source(driver, src, name, page_name)
end

def update_index(driver, prev_version, current_version)
  page_name = "RSS Parser"
  src = driver.src(page_name)
  src.gsub!(/#{prev_version}/, current_version)
  log = "#{prev_version} -> #{current_version}"
  update_source(driver, src, "index", page_name, log)
end

if ARGV.size < 2
  puts "Usage: #{$0} prev_version current_version"
  exit
end

prev_version, current_version = ARGV

end_point = "http://www.cozmixng.org/~rwiki/rw-soap.rb"
driver = RWiki::SOAP::Driver.new(end_point)

%w(ja en).each do |lang|
  %w(README Tutorial Reference).each do |target|
    update_rd(driver, "#{target}.#{lang}")
  end
end

update_index(driver, prev_version, current_version)
