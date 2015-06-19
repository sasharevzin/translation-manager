class RenameParentIdToSourceIdTranslations < ActiveRecord::Migration
  def change
    rename_column :translations, :parent_id, :source_id
  end
end
