require 'rails_helper'

describe User do
  describe '#create' do
    it "is valid with a nickname, email, password, password_confirmation, first_name, last_name, first_name_kana, last_name_kana, birthday" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    
    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last_name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    it "is invalid without a birthday" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end


    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    it "passwordが半角英数字で返ること" do
      user = build(:user, password: "あああああああ", password_confirmation: "あああああああ")
      user.valid?
      expect(user.errors[:password]).to include("は半角英数字で入力して下さい")
    end

    it "passwordが半角英数字で返ること、成功" do
      user = build(:user, password: "aaaa111", password_confirmation: "aaaa111")
      user.valid?
      expect(user).to be_valid
    end

    it "first_nameが全角で返ること" do
      user = build(:user, first_name: "aaa")
      user.valid?
      expect(user.errors[:first_name]).to include("は全角で入力して下さい")
    end

    it "first_nameが全角で返ること、成功" do
      user = build(:user, first_name: "あああ")
      user.valid?
      expect(user).to be_valid
    end

    it "last_nameが全角で返ること" do
      user = build(:user, last_name: "aaa")
      user.valid?
      expect(user.errors[:last_name]).to include("は全角で入力して下さい")
    end

    it "last_nameが全角で返ること、成功" do
      user = build(:user, last_name: "あああ")
      user.valid?
      expect(user).to be_valid
    end

    it "first_name_kanaが全角カタカナで返ること" do
      user = build(:user, first_name_kana: "あああ")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it "first_name_kanaが全角カタカナで返ること、成功" do
      user = build(:user, first_name_kana: "アアア")
      user.valid?
      expect(user).to be_valid
    end

    it "last_name_kanaが全角カタカナで返ること" do
      user = build(:user, last_name_kana: "あああ")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it "last_name_kanaが全角カタカナで返ること、成功" do
      user = build(:user, last_name_kana: "アアア")
      user.valid?
      expect(user).to be_valid
    end
    


  end
end