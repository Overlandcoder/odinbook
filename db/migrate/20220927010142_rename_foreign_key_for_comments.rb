class RenameForeignKeyForComments < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :author_id, :commenter_id
  end
end
