class Product < ApplicationRecord
  enum :category, { electronics: 0, clothing: 1, furniture: 2, books: 3, toys: 4 }
  has_many :scenario_taggings, as: :taggable, dependent: :destroy
  has_many :scenario_tags, through: :scenario_taggings

  has_many :orders

  has_neighbors :embedding

  def similar_products(count = 1)
    nearest_neighbors(:embedding, distance: "euclidean").first(count)
  end

  def calculate_embedding
    ServiceAsyncWrapper.perform_later(CalculateProductEmbeddingService, self)
  end
end
