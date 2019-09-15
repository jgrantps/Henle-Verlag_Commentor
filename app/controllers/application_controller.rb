require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_lab_session_key"
  end

  get '/' do
    "hello from round two"
  end
end
