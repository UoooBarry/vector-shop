class CreateGeminiChat < ActiveRecord::Migration[8.0]
  def change
    Chat.find_or_create_by(model: 'gemini-2.5-flash')
  end
end
