# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'

RSpec.describe 'Builders::Json::User' do
  include GenericSupport

  let!(:user) { FactoryGirl.create(:user) }

  describe 'without tokens' do
    it { expect(Builders::Json::User.new(user).build).to_not be_nil }
    it { expect(Builders::Json::User.new(user).build['errors']).to be_empty }
    it { expect(Builders::Json::User.new(user).build['email']).to eq(user.email) }

    it { expect(Builders::Json::User.new(user).build['auth_token']).to be_nil }
    it { expect(Builders::Json::User.new(user).build['refresh_token']).to be_nil }
  end

  describe 'with tokens' do
    it { expect(Builders::Json::User.new(user, true).build).to_not be_nil }
    it { expect(Builders::Json::User.new(user, true).build['errors']).to be_empty }
    it { expect(Builders::Json::User.new(user, true).build['email']).to eq(user.email) }
    it { expect(Builders::Json::User.new(user, true).build['auth_token']).to_not be_nil }
    it { expect(Builders::Json::User.new(user, true).build['refresh_token']).to_not be_nil }
  end
end
