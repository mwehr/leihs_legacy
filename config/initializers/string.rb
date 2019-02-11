class String
  def numeric?
    begin
      Float(self) != nil
    rescue StandardError
      false
    end
  end
end
