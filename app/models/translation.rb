class Translation < ActiveRecord::Base
  has_many :translations,
           -> { where('id != parent_id') },
           class_name: "Translation",
           foreign_key: "parent_id"
  belongs_to :english_translation, class_name: "Translation"
end