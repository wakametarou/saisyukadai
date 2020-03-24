require 'rails_helper'

RSpec.describe Card, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# describe Card do
#   describe '#create' do
#     it "is valid with a user_id, customer_id, card_id" do
#       card = build(:card)
#       expect(user).to be_valid
#     end

#     it "is invalid without a user_id" do
#       card = build(:card, user_id: nil)
#       card.valid?
#       expect(user.errors[:user_id]).to include("カード情報が正しくありません")
#     end
#   end
# end