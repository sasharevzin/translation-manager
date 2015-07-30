class Source < ActiveRecord::Base
  has_many :translations, dependent: :destroy, inverse_of: :source
  accepts_nested_attributes_for :translations

  validates :text, presence: true
  validates :language, presence: true, locale: true

  def self.supported_languages
    %w(en cs da de el es fi fr it nl no pl pt sv tr)
  end
end
