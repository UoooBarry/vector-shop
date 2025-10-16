class CreateScenarioTaggings < ActiveRecord::Migration[8.0]
  def change
    create_table :scenario_taggings do |t|
      t.references :scenario_tag, null: false, foreign_key: true
      t.references :taggable, polymorphic: true, null: false, index: true

      t.decimal :confidence
      t.text :reason
      t.timestamps
    end
  end
end
