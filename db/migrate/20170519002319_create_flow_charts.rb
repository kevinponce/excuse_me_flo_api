# frozen_string_literal: true

# create table flow_charts
class CreateFlowCharts < ActiveRecord::Migration[5.1]
  def change
    create_table :flow_charts do |t|
      t.string :title
      t.text :markup

      t.references :user
    end
  end
end
