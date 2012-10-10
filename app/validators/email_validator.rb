# Example use:
#   validates :email, email: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    @record, @attribute, @value = record, attribute, value
    @email = Mail::Address.new(@value)
    @tree  = @email.__send__(:tree)
    add_error unless valid?
  rescue Mail::Field::ParseError
    add_error
  end

  private

  def valid?
    !!(domain_and_address_present? && domain_has_more_than_one_atom?)
  end

  def domain_and_address_present?
    @email.domain && @email.address == @value
  end

  def domain_has_more_than_one_atom?
    @tree.domain.dot_atom_text.elements.length > 1
  end

  def add_error
    @record.errors[@attribute] << (options[:message] || 'is not an email')
  end
end
