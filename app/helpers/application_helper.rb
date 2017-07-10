module ApplicationHelper
  # http://qiita.com/walakka-jp/items/339595ab43439bab2518
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-success" }[flash_type.to_sym] || flash_type.to_s
  end

  # http://qiita.com/walakka-jp/items/339595ab43439bab2518
  def flash_messages(opts = {})
    flash.each do |flash_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(flash_type)}") do
          concat message
        end
      )
    end
    nil
  end
end
