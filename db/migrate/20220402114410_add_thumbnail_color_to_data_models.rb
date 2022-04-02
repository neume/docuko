class AddThumbnailColorToDataModels < ActiveRecord::Migration[6.1]
  def change
    add_column :data_models, :thumbnail_color, :string
  end
end
