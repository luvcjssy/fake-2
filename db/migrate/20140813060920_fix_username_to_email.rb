class FixUsernameToEmail < ActiveRecord::Migration
  def change
  	rename_column :accounts, :username, :email
  end
end
