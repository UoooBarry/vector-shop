class AddEmbeddingInCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :embedding, :vector, limit: 3072
  end
end
