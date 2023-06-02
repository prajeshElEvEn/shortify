require 'sinatra'
require 'securerandom'

# Hash to store shortened URLs
URLS = {}

# Home page
get '/' do
  erb :index
end

# Shorten URL
post '/shorten' do
  long_url = params[:long_url]
  short_url = SecureRandom.hex(3) # Generate a random short URL

  # Save the shortened URL
  URLS[short_url] = long_url

  erb :shortened, locals: { short_url: short_url }
end

# Redirect to the original URL
get '/:short_url' do
  short_url = params[:short_url]
  long_url = URLS[short_url]

  redirect long_url if long_url
end
