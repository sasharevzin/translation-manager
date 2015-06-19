class Source < ActiveRecord::Base
  has_many :translations

  validates :text, presence: true
  validates :language, presence: true, locale: true
end
