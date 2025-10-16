class CreateScenarioTags < ActiveRecord::Migration[8.0]
  def change
    create_table :scenario_tags do |t|
      t.string :scenario

      t.timestamps
    end
  end
end
