class Source < ActiveRecord::Base
  has_many :translations, dependent: :destroy, inverse_of: :source
  accepts_nested_attributes_for :translations

  validates :text, presence: true, uniqueness: { scope: :language, if: ->(s) { s.language? } }
  validates :language, presence: true, locale: true

  def self.supported_languages
    %w(en cs da de el es fi fr it nl no pl pt sv tr)
  end

  def self.search(query)
    rs = Source
    rs = where('text LIKE ?', "%#{query[:text]}%") unless query[:text].blank?
    rs = rs.where(language: query[:language]) unless query[:language].blank?
    rs.paginate(page: query[:page], per_page: query[:per_page])
  end
end
