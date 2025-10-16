RubyLLM.configure do |config|
  # config.openai_api_key = ENV['OPENAI_API_KEY'] || Rails.application.credentials.dig(:openai_api_key)
  # config.default_model = "gpt-4.1-nano"
  config.default_model = "gemini-2.5-flash"
  config.default_embedding_model = "gemini-embedding-001"
  config.gemini_api_key = ENV["GEMINI_API_KEY"]

  # Use the new association-based acts_as API (recommended)
  config.use_new_acts_as = true
end
