# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'

RSpec.describe 'Builders::Json::Errors' do
  include GenericSupport

  describe 'no errors' do
    describe 'valid' do
      let!(:user) { FactoryGirl.create(:user) }

      it { expect(Builders::Json::Errors.new(user).build['errors']).to be_empty }
    end

    describe 'invalid' do
      let!(:user) { User.create(FactoryGirl.attributes_for(:user, email: '')) }

      it { expect(Builders::Json::Errors.new(user).build['errors']).to_not be_empty }
    end
  end
end
