# 
# Put your EchoWaves API key here:
# - You can find your API key on your user profile page
#
API_KEY = 'YOUR_API_KEY_HERE'

#### No need to edit below this line (unless you want to off course) ####

%w(rubygems httparty pp).each { |f| require f }

class EchowavesNotifier
  include HTTParty
  format :xml
  base_uri 'https://echowaves.com'
  # headers 'Content-Type' => 'application/xml'

  def initialize( api_key )
    self.class.default_params( :user_credentials => api_key )
  end

  def notifications
    self.class.get('/conversations/new_messages.atom')
  end
end

ew = EchowavesNotifier.new( API_KEY )
pp ew.notifications
