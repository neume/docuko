module ApplicationHelper
  def flash_class(key)
    case key
    when 'notice'
      'bg-success'
    when 'alert'
      'bg-danger'
    end
  end

  def shorten_relative_time(time, current_time: Time.current)
    diff_time = Time.current - time
    if diff_time > 1.day
      time.strftime('%b %d, %Y')
    elsif diff_time > 1.hour
      "#{diff_in_hours(time, current_time).to_i}h"
    elsif diff_time > 1.minute
      "#{diff_in_minutes(time, current_time).to_i}m"
    else
      "#{diff_in_seconds(time, current_time).to_i}s"
    end
  end

  def diff_in_seconds(start_time, end_time)
    (end_time - start_time)
  end

  def diff_in_minutes(start_time, end_time)
    (end_time - start_time) / 60
  end

  def diff_in_hours(start_time, end_time)
    (end_time - start_time) / 60 / 60
  end
end
