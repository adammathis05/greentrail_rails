module ApplicationHelper
  def admin?
    current_traveler&.admin?
  end

  def flash_class_for(type)
    base = "p-4 text-sm font-medium"

    case type.to_sym
    when :notice
        "#{base} bg-green-100 text-green-800 border border-green-200"
    when :alert, :error
        "#{base} bg-red-100 text-red-800 border border-red-200"
    else
        "#{base} bg-gray-100 text-gray-800 border border-gray-200"
    end
  end
end
