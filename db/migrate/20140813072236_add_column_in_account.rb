class AddColumnInAccount < ActiveRecord::Migration
  def change
  	add_column :accounts, :salt, :string
  	
  end
end
