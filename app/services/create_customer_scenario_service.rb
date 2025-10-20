class CreateCustomerScenarioService < ApplicationService
  def initialize(customer)
    @customer = customer
  end

  def call
    prompt = customer_scene_prompt(@customer)
    response = gemini_chat.with_schema(scenario_schema).ask(prompt)
    response.content.each do |result|
      tag = ScenarioTag.find_or_create_by!(scenario: result["scenario"])
      @customer.scenario_taggings.create!(
        scenario_tag: tag,
        confidence: result["confidence"].to_f,
        reason: result["reason"]
      )
    end
  end

  private

  def customer_scene_prompt(customer)
    orders_data = customer.orders.includes(:product).map do |order|
      product = order.product
      {
        product_name: product.name,
        category: product.category,
        description: product.description,
        quantity: order.quantity,
        total_price: order.total_price,
        purchased_at: order.created_at.strftime("%Y-%m-%d %H:%M:%S")
      }
    end

    <<~PROMPT
    You are a shopping behavior analysis assistant. Based on the customer's purchase history below, determine the most likely purchase scenarios for the customer.
    Your output must be strictly in JSON format, with the following keys:
      - "scenario": a short text describing the purchase scenario (e.g., "Gift shopping", "Educational purchase", "Daily necessities")
      - "confidence": a number between 0 and 1 representing how well this scenario fits the customer's behavior
      - "reason": a short explanation of why this scenario fits the customer's purchase history

    Do not include any additional text or explanation outside the JSON.

    Customer purchase history:
    #{orders_data.to_json}

    Example output:
    [{
      "scenario": "Educational purchase",
      "confidence": 0.90,
      "reason": "The customer frequently buys STEM-related products like science kits, indicating a focus on educational activities."
    }]
    PROMPT
  end

  def gemini_chat
    @gemini_chat ||= Chat.find_or_create_by!(model: "gemini-2.5-flash")
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
