require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "60d8e5ced05c26c86cc87850fb4b484227b42c074e63c3ed07a8fcef7cf010548d411d9e527783daa8e7f62e9cb50a95e8c67b9d5aff31b6c61035ae7bc22b7d"
    use Rack::Flash
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

end
