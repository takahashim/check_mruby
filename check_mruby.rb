#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

FileUtils.mkdir_p "log"
FileUtils.mkdir_p "conf"

if File.exist?("mruby")
  system("cd mruby && git pull")
else
  system("git clone --depth=1 -b master https://github.com/mruby/mruby.git")
end

TEST_SCRIPT="run_test.sh"

File.open(TEST_SCRIPT, "w") do |f|
  f.write("#!/bin/bash\n\n## build test script for mrbgems\n\n")
  f.write(%q|BASEDIR="$(cd $(dirname $0); pwd)"|+"\n")

  Dir.glob("./mgem-list/*.gem").sort.each do |gem|
    content = YAML.load_file(gem)

    bc_file = <<-EOB
MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  conf.gembox 'default'
end

MRuby::Build.new('test') do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  enable_debug
  conf.enable_bintest
  conf.enable_test

  conf.gembox 'default'
  conf.gem :git => "#{content['repository']}"
end
EOB

    File.write("conf/build_config_#{content['name']}.rb", bc_file)
    f.write("cd $BASEDIR/mruby && echo \"test #{content['name']}...\" && MRUBY_CONFIG=../conf/build_config_#{content['name']}.rb rake clean test &> ../log/log_#{content['name']}-#{Time.now.strftime("%Y%m%d")}.txt\n")
  end
end

FileUtils.chmod(0755, TEST_SCRIPT)

puts "run #{TEST_SCRIPT}..."
system("bash #{TEST_SCRIPT}")
