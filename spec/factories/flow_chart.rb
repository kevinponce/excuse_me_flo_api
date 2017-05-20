# frozen_string_literal: true

# spec/factories/user.rb
FactoryGirl.define do
  factory :flow_chart do
    title 'Flow Chart Title'
    markup 'st=>start: Start\n e=>end: End\n st->e'

    association :user

    trait :flow_chart_new do
      title 'New Title'
      markup 'New Markup'
    end

    trait :other do
      title 'Other Title'
      markup 'Other Markup'
    end
  end
end
