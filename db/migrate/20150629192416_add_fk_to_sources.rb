class AddFkToSources < ActiveRecord::Migration
  def change
    add_foreign_key :translations, :sources
  end
end
