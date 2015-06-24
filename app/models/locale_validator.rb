require 'iso'
require 'yaml'

class LocaleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.blank? || ISO::Tag.new(value).valid?
      record.errors[attribute] << (options[:message] || 'is not valid ')
    end
  end
end
