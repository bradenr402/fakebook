module ApplicationHelper
  def formatted_date(date)
    date.strftime('%B %e, %Y')
  end

  def formatted_time(time)
    time.strftime('%l:%M%P')
  end

  def formatted_datetime(datetime)
    if datetime.all_day == Time.current.all_day
      datetime.strftime('today at %l:%M%P')
    else
      datetime.strftime('%B %e, %Y at %l:%M%P')
    end
  end
end
