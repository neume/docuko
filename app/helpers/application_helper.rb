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

  def link_to_add_fields(form, association, template = nil, options = {}, &block)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id

    template ||= "#{association.to_s.singularize}_fields"

    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render(template, f: builder)
    end

    link_to('#', options.merge(data: { id: id, fields: fields.gsub("\n", '') }), &block)
  end
end
