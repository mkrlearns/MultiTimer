require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, 'ih11Sdfn#kkli!s2_hJd'
  end

  helpers do
    def current_user() User.find_by(id: session[:user_id]) end
    def logged_in?() !!current_user end
  end

  get('/') { erb :index }

end
