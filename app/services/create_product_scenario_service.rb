class CreateProductScenarioService < ApplicationService
  EMBDEDING_DIMENSIONS = 3072.freeze

  def initialize(product)
    @product = product
  end

  def call
    prompt = product_scene_prompt(@product)
    response = gemini_chat.with_schema(scenario_schema).ask(prompt)
    response.content.each do |result|
      tag = ScenarioTag.find_or_create_by!(scenario: result["scenario"])
      @product.scenario_taggings.create!(
        scenario_tag: tag,
        confidence: result["confidence"].to_f,
        reason: result["reason"]
      )
    end
  end

  private

  def product_scene_prompt(product)
    <<~PROMPT
    You are a shopping behavior analysis assistant. Based on the product information below, determine the most likely purchase scenario for the product.
    Your output must be strictly in JSON format, with the following keys:
      - "scenario": a short text describing the purchase scenario (e.g., "Birthday gift", "Daily use", "Office supplies")
      - "confidence": a number between 0 and 1 representing how well this scenario fits the product
      - "reason": a short explanation of why this product fits this scenario

    Do not include any additional text or explanation outside the JSON.

    Product information:
    {
      "name": "#{product.name}",
      "category": "#{product.category}"
    }

    Example output:
    [{
      "scenario": "Daily use",
      "confidence": 0.85,
      "reason": "The product is a casual cotton T-shirt suitable for everyday wear."
    }]
    PROMPT
  end

  def gemini_chat
    @gemini_chat || @gemini_chat = Chat.find_or_create_by!(model: "gemini-2.5-flash")
  end

  def scenario_schema
    {
      type: "array",
      items: {
        type: "object",
        properties: {
          scenario: { type: "string" },
          confidence: { type: "number" },
          reason: { type: "string" }
        },
        required: %w[scenario confidence reason]
      }
    }
  end
end
