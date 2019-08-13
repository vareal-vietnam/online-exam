module ApplicationHelper
  def full_title(page_title = '')
    base_title = t 'common.page_title'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def format_name_test(text, max_character)
    if text.length > max_character
      return "<span title='#{text}'>#{text.slice(0..max_character)}...</span>"
    end

    "<span title='#{text}'>#{text}</span>"
  end
end
