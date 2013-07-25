require 'rubygems'
require 'httparty'
require 'json'
require 'crack'
require 'pp'

class Zendesk
	attr_accessor :response

	include HTTParty
	default_params :output => 'json'
	format :json
  #base_uri = "https://nitrousio.zendesk.com/api/v2"

  def initialize
  	auth = {:username => ENV['ZENDESK_USERNAME'], :password => ENV['ZENDESK_PASSWORD']}
  	@response = HTTParty.get("https://nitrousio.zendesk.com/api/v2/tickets.json", :basic_auth => auth)
  end

end

bug_hash = {}
feedback_hash = {}
issue_hash = {}

zendesk = Zendesk.new.response
#all_tags = zendesk.body["tags"].map

parsed = JSON.parse(zendesk.body)

pp parsed

# parsed.each do |ticket|

# 	name = tag.name
	
# 	if status = "pending"
# 		if bug_hash.has_key?(name)
# 			bug_hash[name] = bug_hash[name] + 1	
# 		elsif feedback_hash.has_key?(name)
# 			feedback_hash[name] = feedback_hash[name] + 1	
# 		elsif issue_hash.has_key?(name)
# 			issue_hash[name] = issue_hash[name] + 1	
# 		elsif category = "bug"
# 			bug_hash[tag] = 0
# 		elsif category = "feedback"
# 			feedback_hash[tag] = 0
# 		elsif category = "issue"
# 			issue_hash[tag] = 0
# 		end
# 	end
# end