# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }

  it { expect(user.errors).to be_empty }
  it { expect(user.update_attributes(email: nil)).to be_falsey }

  it { expect(FactoryGirl.build(:user)).to be_valid }

  it { expect(FactoryGirl.build(:user, email: '')).to be_invalid }
  it { expect(FactoryGirl.build(:user, email: 'example')).to be_invalid }
  it { expect(FactoryGirl.build(:user, email: 'ex@ample')).to be_invalid }
  it { expect(FactoryGirl.build(:user, email: 'example.com')).to be_invalid }

  it { expect(FactoryGirl.build(:user, password: '')).to be_invalid }
  it { expect(FactoryGirl.build(:user, password: nil)).to be_invalid }
  it { expect(FactoryGirl.build(:user, password: '12345')).to be_invalid }
  it { expect(FactoryGirl.build(:user, password: '123456')).to be_valid }
end
