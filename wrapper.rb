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

all_tickets = client.search(:query => "status:pending tags:php")
all_tickets.each do |t|
  puts t
  puts "ID: #{t.id} Status: #{t.status} Tags: #{t.tags} #{t.url}"
end
