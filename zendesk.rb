require 'rubygems'
require 'httparty'
require 'json'
require 'pp'

class Zendesk
  attr_accessor :response

  include HTTParty
  default_params :output => 'json'
  format :json
  #base_uri = "https://nitrousio.zendesk.com/api/v2"

  def initialize
    auth = {:username => ENV['ZENDESK_USERNAME'], :password => ENV['ZENDESK_PASSWORD']}
    @response = HTTParty.get("https://nitrousio.zendesk.com/api/v2/tickets.json", 
                     :basic_auth => auth)
  end

end

zendesk = Zendesk.new.response
#all_tags = zendesk.body["tags"].map

parsed = JSON.parse(zendesk.body)

#pp parsed