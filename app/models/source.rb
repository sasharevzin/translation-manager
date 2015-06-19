class Source < ActiveRecord::Base
  has_many :translations
  accepts_nested_attributes_for :translations

  validates :text, presence: true
  validates :language, presence: true, locale: true
end
