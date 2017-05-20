# frozen_string_literal: true

# flowchart model
class FlowChart < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :markup, presence: true
end
