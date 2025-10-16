class AddEmeddingInScenarioTags < ActiveRecord::Migration[8.0]
  def change
    add_column :scenario_tags, :embedding, :vector, limit: 3072
  end
end
