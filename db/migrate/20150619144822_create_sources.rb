class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :language
      t.text :text
      t.string :context
      t.timestamps null: false
    end
    add_index :sources, :language
    add_index :sources, :context
    add_index :sources, :text, length: 100
  end
end
