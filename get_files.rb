#!/usr/bin/env ruby
## 
## Hpricot needs to be installed
##    sudo gem install hpricot
##
## Download the "Uploaded Files" html source 
## Find the prefix url in the grab the url section
## run with
## get_files.rb <sourceurl> <prefixurl> <email> <password>
##
##

require 'rubygems'
require 'hpricot'
require 'net/http'

source = ARGV[0]
prefix = ARGV[1]
email, password = ARGV[2], ARGV[3]


def read_remote_file(url, username = nil, password = nil)
  uri = URI.parse(url)
  Net::HTTP.start(uri.host, uri.port) do |http|
    req = Net::HTTP::Get.new(uri.path)    
    req.basic_auth(username, password) if username && password
    response = http.request(req)
    response.body
  end
end

def download_file()
  
end


doc = Hpricot.parse(read_remote_file(source, email, password))
doc.search( "//div[@class='asset-image']//img" ).each do |asset|
  url = "#{prefix}/#{asset.attributes['title']}"
  # TODO: use Net::HTTP or 'open-uri' to download the file so it works on windows as well
  `wget #{url}`
end