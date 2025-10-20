class Customer < ApplicationRecord
  has_many :orders
  has_many :scenario_taggings, as: :taggable, dependent: :destroy
  has_many :scenario_tags, through: :scenario_taggings

  has_neighbors :embedding


  def calculate_embedding
    CalculateScenarioRelatedEmbeddingService.async_call(self)
  end

  def similar_products(count = 1)
    vec_sql = ActiveRecord::Base.connection.quote(embedding.to_s)

    sql = <<-SQL.squish
      SELECT products.*,
             1 - (products.embedding <=> #{vec_sql}) AS cosine_similarity
      FROM products
      WHERE products.embedding IS NOT NULL
      ORDER BY cosine_similarity DESC
      LIMIT #{count.to_i}
    SQL

    Product.find_by_sql(sql)
  end
end
