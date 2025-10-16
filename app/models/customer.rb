class Customer < ApplicationRecord
  has_many :orders
  has_many :scenario_taggings, as: :taggable, dependent: :destroy
  has_many :scenario_tags, through: :scenario_taggings
end
