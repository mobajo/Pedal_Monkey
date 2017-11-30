module ApplicationHelper
  def title(text)
    content_for :title, text
  end

  def yield_with_default(holder, default)
    if content_for?(holder)
      content_for(holder).squish
    else
      default
    end
  end
end
