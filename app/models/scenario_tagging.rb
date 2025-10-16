class ScenarioTagging < ApplicationRecord
  belongs_to :scenario_tag
  belongs_to :taggable, polymorphic: true
end
