require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:wikis) }

  it "responds to role" do
    expect(user).to respond_to(:role)
  end

  it "responds to standard" do
    expect(user).to respond_to(:standard?)
  end

  it "responds to premium" do
    expect(user).to respond_to(:premium?)
  end

  it "responds to admin" do
    expect(user).to respond_to(:admin?)
  end

  describe "roles" do
    it "is standard by default" do
      expect(user.role).to eq("standard")
    end
  end
end
