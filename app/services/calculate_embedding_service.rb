class CalculateEmbeddingService < ApplicationService
  def initialize(object, attributes)
    @object = object
    @attributes = attributes
    raise ArgumentError, "Object does not have embedding attribute" unless @object.respond_to?("embedding=")
    raise ArgumentError, "attributes should not be empty" if @attributes.empty?
  end

  def call
    response = RubyLLM.embed(@attributes.compact.join("/"))
    @object.update!(embedding: response.vectors)
  end
end
