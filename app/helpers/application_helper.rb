module ApplicationHelper

  def auth_token
    # This creates us an auth token tage with ruby.
    # We need to embed with ruby, and clean our output so we dont get XSS
    html = '<input type="hidden" name="authenticity_token"'
    html += "value=\"#{h(form_authenticity_token)}\"/>"

    html.html_safe
  end

  # Use to add my fontawesome kit to head, otherwise breaks formatting.
  def fontawesome_kit_tag
    html = '<script src="https://kit.fontawesome.com/6ccd5368f9.js" crossorigin="anonymous"></script>'
    html.html_safe
  end
  # Use to add my google icon kit to head, otherwise breaks formatting.
  # (not currently using)
  def google_icons_kit
    html = '<script src="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"></script>'
    html.html_safe
  end


end
