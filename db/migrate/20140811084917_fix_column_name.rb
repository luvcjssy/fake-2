class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :images, :name, :url
  end
end
