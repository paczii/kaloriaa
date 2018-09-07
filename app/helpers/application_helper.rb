module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "E-Grocery EUS"
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


  def costmodel_to_text(id)
    if id == 2
      text = "Abonnement"
    elsif id == 1
      text = "Pay per Order"
    end

    return text
  end


  def durability_to_text(id)
    if id == 2
      text = "Tiefkühlfach"
    elsif id == 1
      text = "Kühlfach"
    else
      text = "Keine"
    end

    return text
  end


  def concept_to_text(id)
    if id == 5
      text = "Hub"
    elsif id == 4
      text = "Warehouse"
    elsif id == 3
      text = "Pick-Up Station"
    elsif id == 2
      text = "Store-Pick-Up, Home-Delivery"
    elsif id == 1
      text = "Store-Pick-Up"
    else
      text = "Alle"
    end

    return text
  end

  def opttype_to_text(txt)
    if txt == 3
      text = "Delivery Only"
    elsif txt == 2
      text = "Pick-Up Home Only"
    elsif txt == 1
      text = "Wie gewünscht"
    elsif txt == 4
      text = "Pick-Up Work Only"
    elsif txt == 1
    end

    return text
  end

  def typey_to_text(id)
    if id == 3
      text = "Kunde zu Geschäft"
    elsif id == 2
      text = "Geschäft zu Kunde"
    elsif id == 1
      text = "Kunde zu Kunde"
    elsif id == 4
      text = "Arbeit zu Geschäft"
    elsif id == 5
      text = "Arbeit zu Kunde"
    end

    return text
  end

  def boolean_to_text(txt)
    if txt == true
      text = "Ja"
    elsif txt == false
      text = "Nein"
    end

    return text
  end


  def orderstatus_to_text(id)
    if id == 3
      text = "Abgeschlossen"
    elsif id == 2
      text = "Zugeordnet"
    elsif id == 1
      text = "Aufgegeben"
    else
      text = "Alle"
    end

    return text
  end


  def method_to_text(id)
    if id == 3
      text = "Home-Delivery"
    elsif id == 2
      text = "Pick-Up (Work)"
    elsif id == 1
      text = "Pick-Up (Home)"
    else
      text = "Alle"
    end

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

  def storesselection_to_text(id)
    if id == 12
      text = "Alle Geschäfte"
    elsif id == 124
      text = "Geschäfte und Pick-Up Stationen"
    elsif id == 34
      text = "Pick-Up Stationen und Zentrallager"
    elsif id == 345
      text = "Pick-Up Stationen, Zentrallager und Hubs"
    elsif id == 3
      text = "Pick-Up Stationen"
    elsif id == 2
      text = "Geschäfte mit Delivery"
    elsif id == 4
      text = "Zentrallager"
    elsif id == 5
      text = "Hubs"
    elsif id == 245
      text = "Alle"
    else
      text = "Alle"
    end

    return text
  end


  def orderselection_to_text(id)
    if id == 12
      text = "Alle Pick-Up"
    elsif id == 1
      text = "Pick-Up Home"
    elsif id == 2
      text = "Pick-Up Work"
    elsif id == 3
      text = "Home-Delivery"
    elsif id == nil
      text = "Wie angegeben"
    else
      text = "Alle"
    end

    return text
  end

end

