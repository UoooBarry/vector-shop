class CalculateProductEmbeddingService < ApplicationService
  VECTOR_DIM = 3072.freeze

  def initialize(product)
    @product = product
  end

  def call
    return if @product.embedding.present?
    return if @product.scenario_tags.empty?

    vec = build_product_vector(@product)
    return if vec.nil?

    @product.update!(embedding: vec)
  end

  private

  # 加权平均
  def build_product_vector(product)
    tag_matchings = product.scenario_taggings.includes(:scenario_tag)
    return nil if tag_matchings.empty?

    embeddings = tag_matchings.map { |tag| tag.scenario_tag.embedding }

    weighted_sum = Array.new(VECTOR_DIM, 0.0)
    total_weight = 0.0

    tag_matchings.each_with_index do |ts, i|
      next unless embeddings[i]

      embeddings[i].each_with_index do |val, idx|
        weighted_sum[idx] += val * ts.confidence
      end
      total_weight += ts.confidence
    end

    weighted_sum.map { |v| v / total_weight }
  end
end
