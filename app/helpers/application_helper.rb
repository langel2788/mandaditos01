module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Mandaditos01"      
    end
  end
end
