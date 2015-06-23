class Source < ActiveRecord::Base
  has_many :translations, dependent: :destroy
  accepts_nested_attributes_for :translations

  validates :text, presence: true
  validates :language, presence: true, locale: true

  def self.supported_languages
    %w{de-DE en-GB en-US es-ES fr-FR it-IT nb-NO nl-NL pt-PT}
  end
end
