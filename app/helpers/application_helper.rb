module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

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
