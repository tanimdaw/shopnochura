class ChangeUsernameTypeInUser < ActiveRecord::Migration
  def up
  	change_column :users, :username, :string, :null => true
  end

  def down
  	change_column :users, :username, :string, :null => false
  end
end
