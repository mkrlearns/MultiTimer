class TimersController < ApplicationController

  def get_seconds(minutes = 0, seconds = 0)
    (minutes.to_i * 60) + seconds.to_i
  end

  post '/timer' do
    seconds = get_seconds(params[:minutes], params[:seconds])
    timer = Timer.new(seconds: seconds, running: false, remaining: seconds, started: Time.new.utc)
    current_user.timers << timer
    redirect '/' if current_user.save
  end

  patch '/timer/:id/edit' do
    seconds = get_seconds(params[:minutes], params[:seconds])
    timer = Timer.find_by_id(params[:id])
    redirect '/' if timer.update(seconds: seconds, remaining: seconds)
  end

  delete '/timer/:id/delete' do
    timer = Timer.find_by_id(params[:id])
    redirect '/' if timer.destroy
  end

end
