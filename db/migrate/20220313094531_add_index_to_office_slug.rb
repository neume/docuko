class AddIndexToOfficeSlug < ActiveRecord::Migration[6.1]
  def change
    add_index :offices, :slug, unique: true
  end
end
