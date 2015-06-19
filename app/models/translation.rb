class Translation < ActiveRecord::Base
  belongs_to :source

  validates :text, presence: true
  validates :language, presence: true, locale: true
end
