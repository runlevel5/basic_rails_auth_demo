module ApplicationHelper
  def flash_messages
    return '' if flash.empty?

    data = flash.to_hash
    flash.clear unless Rails.env.test?

    content_tag 'div', class: 'flash' do
      data.map do |type, message|
        unless message.blank?
          content_tag(:p) do
            content_tag(:span, message.html_safe)
          end
        end
      end.join("\n").html_safe
    end
  end
end
