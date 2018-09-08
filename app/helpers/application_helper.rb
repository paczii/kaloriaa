module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Kaloriaa"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def text_with_badge(text, badge_value=nil)
    badge = content_tag :span, number_to_currency(badge_value, :unit => "€", format: "%n %u" ), class: 'badge'
    text = raw "#{text} #{badge}" if badge_value
    return text
  end

  def text_with_badge2(text, badge_value=nil)
    badge = content_tag :span, badge_value, class: 'badge'
    text = raw "#{text} #{badge}" if badge_value
    return text
  end




  def number_to_time(id)
    hours = id.split("-")
    h1 = hours[0].to_f * 60 - 60 * 60
    h2 = hours[1].to_f * 60 - 60 * 60

    time1 = Time.at(h1).strftime("%H:%M")
    time2 = Time.at(h2).strftime("%H:%M")

    time = time1 + " - " + time2

    return time
  end

  def singlenumber_to_time(id)
    h = id.to_f * 60 - 60 * 60

    time = Time.at(h).strftime("%H:%M")


    return time
  end




end

