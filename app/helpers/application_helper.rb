module ApplicationHelper
  def flash_class(key)
    case key
    when 'notice'
      'bg-success'
    when 'alert'
      'bg-danger'
    end
  end
end
