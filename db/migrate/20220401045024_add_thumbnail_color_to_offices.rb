class AddThumbnailColorToOffices < ActiveRecord::Migration[6.1]
  def change
    add_column :offices, :thumbnail_color, :string
  end
end
