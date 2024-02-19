class RenamePostCadeToPostCode < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :post_cade, :post_code
  end
end
