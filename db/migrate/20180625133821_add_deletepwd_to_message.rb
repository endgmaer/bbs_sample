class AddDeletepwdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :deletepwd, :string
  end
end
