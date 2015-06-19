class Translation < ActiveRecord::Base
  belongs_to :source

  validates :text, presence: true
  validates :language, presence: true
  validates :source_id, presence: true, numericality: true
end
