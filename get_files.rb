#!/usr/bin/env ruby
## 
## Hpricot needs to be installed
##    sudo gem install hpricot
##
## Download the "Uploaded Files" html source 
## Find the prefix url in the grab the url section
## run with
## get_files.rb <htmsource> <prefixurl>
##
##

require 'rubygems'
require 'hpricot'

source = ARGV[0]
prefix = ARGV[1]

f = File.open(source, "r")
doc = Hpricot.parse(f)
doc.search( "//div[@class='asset-image']//img" ).each do |asset|
  url="#{prefix}/#{asset.attributes['title']}"
  `wget #{url}`
end

f.close

