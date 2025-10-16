class ScenarioTag < ApplicationRecord
  has_many :scenario_taggings, dependent: :destroy
  has_many :products, through: :scenario_taggings, source: :taggable, source_type: "Product"
  has_many :customers, through: :scenario_taggings, source: :taggable, source_type: "Customer"

  has_neighbors :embedding

  after_create_commit :calculate_embedding

  def calculate_embedding
    ServiceAsyncWrapper.perform_later(CalculateEmbeddingService, self, [ scenario ])
  end
end
