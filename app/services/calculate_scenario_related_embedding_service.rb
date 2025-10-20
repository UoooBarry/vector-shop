class CalculateScenarioRelatedEmbeddingService < ApplicationService
  VECTOR_DIM = 3072.freeze

  def initialize(object)
    @object = object
  end

  def call
    return if @object.embedding.present?
    return if @object.scenario_tags.empty?

    vec = build_vector(@object)
    return if vec.nil?

    @object.update!(embedding: vec)
  end

  private

  # 加权平均
  def build_vector(product)
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
