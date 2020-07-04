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
  get('/logout') { session.destroy; redirect '/' }

  post '/login' do
    @user = User.find_by(email: params[:email])
    if !@user
      @user = User.new(email: params[:email], password: params[:password])
      @user.save
    elsif !@user.authenticate(params[:password])
      puts "An account with that email already exists." # Change to error msg
      redirect '/'
      return
    end
    session[:user_id] = @user.id
    erb :index
  end

end
