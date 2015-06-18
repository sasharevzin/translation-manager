class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :parent_id
      t.string :language
      t.string :context
      t.text :text

      t.timestamps null: false
    end
    add_index :translations, :parent_id
    add_index :translations, :language
  end
end
