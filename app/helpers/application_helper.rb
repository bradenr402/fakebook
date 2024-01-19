module ApplicationHelper
  def formatted_date(date)
    date.strftime('%b %e, %Y')
  end

  def formatted_time(time)
    time.strftime('%l:%M%P')
  end

  def formatted_datetime(datetime)
    if datetime.all_day == Time.current.all_day
      datetime.strftime('today, %l:%M%P')
    elsif datetime.all_year == Time.current.all_year
      datetime.strftime('%b %e, %l:%M%P')
    else
      datetime.strftime('%b %e, %Y, %l:%M%P')
    end
  end
end
