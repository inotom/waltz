module ApplicationHelper

  # ページ毎の完全なタイトルを返す
  def full_title(page_title = '')
    base_title = 'Waltz'
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  def datetime_full_fmt(time)
    datetime_fmt(time, "%Y年%m月%d日")
  end

  def datetime_fmt(time, fmt = "%m月%d日")
    time.strftime(fmt) unless time.nil?
  end

  def truncateja(text, length: 30, truncate_string: '…')
    return if text.nil?
    chars = text.split(//)
    chars.length > length ? chars[0..(length-1)].join + truncate_string : text
  end
end
