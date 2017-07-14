require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:my_user) { create(:user) }
  let(:my_wiki) { create(:wiki, user: my_user) }

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "should have title, body, private and user attributes" do
      expect(my_wiki).to have_attributes(title: my_wiki.title, body: my_wiki.body, private: my_wiki.private, user: my_wiki.user)
    end
  end
end
