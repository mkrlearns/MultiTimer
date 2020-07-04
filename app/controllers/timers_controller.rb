class TimersController < ApplicationController

  post '/timer' do
    timer = Timer.new(seconds: seconds, running: false, remaining: seconds, started: Time.new.utc)
    user = current_user
    user.timers << timer
    redirect '/' if user.save
  end

  patch '/timer/:id/edit' do
    timer = Timer.find_by_id(params[:id])
    redirect '/' if timer.update(seconds: seconds, remaining: seconds)
  end

  delete '/timer/:id/delete' do
    timer = Timer.find_by_id(params[:id])
    redirect '/' if timer.destroy
  end

end
