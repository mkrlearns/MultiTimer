require './config/environment'
require 'sinatra/flash'
class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    register Sinatra::Flash
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, 'ih11Sdfn#kkli!s2_hJd'
  end

  helpers do
    def current_user() User.find_by(id: session[:user_id]) end
    def logged_in?() !!current_user end
    def seconds_string(secs) "%02d:%02d" % [secs / 60 % 60, secs % 60] end
  end

  get '/' do
    if logged_in?
      current_user.timers.each do |timer|
        if timer.running
          time_passed = Time.new.utc.to_i - timer.started.to_i
          timer.update(remaining: timer.remaining - time_passed)
          timer.update(started: Time.new.utc)
          timer.update(remaining: 0, running: false) if timer.remaining < 1
        end
      end
    end
    erb :index
  end

  get('/logout') { session.destroy; redirect '/' }

  post '/login' do
    user = User.find_by(email: params[:email])
    if !user
      user = User.new(email: params[:email], password: params[:password], error: "")
      user.save
    elsif !user.authenticate(params[:password])
      flash[:error] = "An account with that email already exists."
      redirect '/'
      return
    end
    session[:user_id] = user.id
    erb :index
  end

end
