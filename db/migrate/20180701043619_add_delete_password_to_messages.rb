class AddDeletePasswordToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :password, :string
  end
end
