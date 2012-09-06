class EmailValidator < ActiveModel::EachValidator
  RFC_2822_AND_RFC_3696_SPEC_REGEX = %r{^[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$}i

  def validate_each(record, attribute, value)
    unless value =~ RFC_2822_AND_RFC_3696_SPEC_REGEX
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end
