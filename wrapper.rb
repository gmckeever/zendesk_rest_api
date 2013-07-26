require 'rubygems'
require 'zendesk_api'
require 'pp'

client = ZendeskAPI::Client.new do |config|
      # Mandatory:
    
      config.url = "https://nitrousio.zendesk.com/api/v2" # e.g. https://mydesk.zendesk.com/api/v2
    
      config.username = ENV['ZENDESK_USERNAME']
    
      # Choose one of the following depending on your authentication choice
      #config.token = ENV['ZENDESK_TOKEN']
      config.password = ENV['ZENDESK_PASSWORD'] 
    
      # Optional:
    
      # Retry uses middleware to notify the user
      # when hitting the rate limit, sleep automatically,
      # then retry the request.
      config.retry = true
    
      # Logger prints to STDERR by default, to e.g. print to stdout:
      require 'logger'
      config.logger = Logger.new(STDOUT)
    
      # Changes Faraday adapter
      # config.adapter = :patron
    
      # Merged with the default client options hash
      config.client_options = { :ssl => false }
    
      # When getting the error 'hostname does not match the server certificate'
      # use the API at https://yoursubdomain.zendesk.com/api/v2
end

frequencies = Hash.new(0)

request = client.search(:query => "status:pending")

request.each do |t|
  #puts "ID: #{t.id} Status: #{t.status} Tags: #{t.tags} #{t.url}"
  #puts "tags: #{t.tags}"
  t.tags.each { |x| frequencies[x] += 1 }
end

frequencies = frequencies.sort_by {|a, b| b }
frequencies.reverse!
frequencies.each { |tag, frequency| puts tag + " " + frequency.to_s }

# ticket_type = t.class
#   case ticket_type
#     when "question"
#       #puts t
#       #puts "ID: #{t.id} Status: #{t.status} Tags: #{t.tags}"
#       puts "question"
#     when "incident"
#       #puts "ID: #{t.id} Status: #{t.status} Tags: #{t.tags}"
#     when "problem"
#       #puts "ID: #{t.id} Status: #{t.status} Tags: #{t.tags}"
#       puts "problem"
#     else

#   end

#results = client.search(:query => "status:pending")
#results.each do |t|