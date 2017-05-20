# frozen_string_literal: true

# model base class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
