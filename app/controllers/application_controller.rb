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
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id if user && user.authenticate(params[:password])
    redirect '/'
  end

  post '/signup' do
    [params[:username], params[:email], params[:password]].each do |param|
      redirect '/signup' if param.empty?
    end
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect '/'
  end

end
