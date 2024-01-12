module ApplicationHelper
  def formatted_date(date)
    date.strftime('%B %e, %Y')
  end

  def formatted_time(time)
    time.strftime('%l:%M%P')
  end

  def formatted_datetime(datetime)
    datetime.strftime('%B %e, %Y at %l:%M%P')
  end
end
