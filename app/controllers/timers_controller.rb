class TimersController < ApplicationController

  def get_seconds(minutes = 0, seconds = 0)
    (minutes.to_i * 60) + seconds.to_i
  end

  def zero_check(seconds)
    if seconds < 1
      redirect '/' #add error
      true
    end
  end

  post '/timer' do
    seconds = get_seconds(params[:minutes], params[:seconds])
    return if zero_check(seconds)
    timer = Timer.new(seconds: seconds, running: false, remaining: seconds, started: Time.new.utc, title: params[:title])
    current_user.timers << timer
    redirect '/' if current_user.save
  end

  patch '/timer/:id/edit' do
    seconds = get_seconds(params[:minutes], params[:seconds])
    return if zero_check(seconds)
    timer = Timer.find_by_id(params[:id])
    redirect '/' if timer.update(seconds: seconds, remaining: seconds, title: params[:title])
  end

  delete '/timer/:id/delete' do
    timer = Timer.find_by_id(params[:id])
    redirect '/' if timer.destroy
  end

  patch '/timer/:id/toggle' do
    timer = Timer.find_by_id(params[:id])
    if timer.running
      time_passed = Time.new.utc.to_i - timer.started.to_i
      timer.update(remaining: timer.remaining - time_passed)
    else
      timer.update(started: Time.new.utc)
    end
    timer.update(running: !timer.running)
    redirect '/'
  end

  patch '/timer/:id/reset' do
    timer = Timer.find_by_id(params[:id])
    redirect '/' if timer.update(remaining: timer.seconds, started: Time.new.utc, running: false)
  end

end
