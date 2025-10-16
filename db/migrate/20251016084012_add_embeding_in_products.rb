class AddEmbedingInProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :embedding, :vector, limit: 3072
  end
end
