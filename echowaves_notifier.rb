# 
# Put your EchoWaves API key here:
# - You can find your API key on your user profile page
#
API_KEY = 'YOUR_API_KEY_HERE'

#### No need to edit below this line (unless you want to off course) ####

%w(rubygems httparty pp).each { |f| require f }

class EchowavesNotifier
  include HTTParty
  format :json
  base_uri 'https://echowaves.com'
  headers 'Content-Type' => 'application/json'

  def initialize( api_key )
    self.class.default_params( :user_credentials => api_key )
  end

  def notifications
    self.class.get( '/conversations/new_messages.json' )
  end
end

output = ''
updates = EchowavesNotifier.new( API_KEY ).notifications

if updates.empty?
  output = 'No new convo updates'
else
  updates.each do |update|
    output << "#{sprintf( "%3.3s", update['subscription']['new_messages_count'] )} - #{update['subscription']['convo_name']}\n"
  end
end

puts output
