class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[-.\w+]+@[-.a-z\d]+\.[a-z]{2,}$/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end
    
