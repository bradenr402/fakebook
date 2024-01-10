module ApplicationHelper
  def formatted_date(date)
    date.strftime('%B %d, %Y')
  end

  def formatted_time(time)
    time.strftime('%I:%M %p')
  end

  def formatted_datetime(datetime)
    datetime.strftime('%B %d, %Y at %I:%M %p')
  end
end
