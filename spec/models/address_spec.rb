require 'rails_helper'

describe Address do
  describe '#create' do
    it "is valid with a sendfirst_name, sendlast_name, sendfirst_name_kana, sendlast_name_kana, postal_code, prefecture, city, address_number" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "is invalid without a sendfirst_name" do
      address = build(:address, sendfirst_name: nil)
      address.valid?
      expect(address.errors[:sendfirst_name]).to include("can't be blank")
    end

    it "is invalid without a sendlast_name" do
      address = build(:address, sendlast_name: nil)
      address.valid?
      expect(address.errors[:sendlast_name]).to include("can't be blank")
    end

    it "is invalid without a sendfirst_name_kana" do
      address = build(:address, sendfirst_name_kana: nil)
      address.valid?
      expect(address.errors[:sendfirst_name_kana]).to include("can't be blank")
    end

    it "is invalid without a sendlast_name_kana" do
      address = build(:address, sendlast_name_kana: nil)
      address.valid?
      expect(address.errors[:sendlast_name_kana]).to include("can't be blank")
    end

    it "is invalid without a postal_code" do
      address = build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end

    it "is invalid without a prefecture" do
      address = build(:address, prefecture: nil)
      address.valid?
      expect(address.errors[:prefecture]).to include("can't be blank")
    end

    it "is invalid without a city" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    it "is invalid without a address_number" do
      address = build(:address, address_number: nil)
      address.valid?
      expect(address.errors[:address_number]).to include("can't be blank")
    end

    it "sendfirst_nameが全角で返ること" do
      address = build(:address, sendfirst_name: "aaa")
      address.valid?
      expect(address.errors[:sendfirst_name]).to include("は全角で入力して下さい")
    end

    it "sendfirst_nameが全角で返ること、成功" do
      address = build(:address, sendfirst_name: "あああ")
      address.valid?
      expect(address).to be_valid
    end

    it "sendlast_nameが全角で返ること" do
      address = build(:address, sendlast_name: "aaa")
      address.valid?
      expect(address.errors[:sendlast_name]).to include("は全角で入力して下さい")
    end

    it "sendlast_nameが全角で返ること、成功" do
      address = build(:address, sendlast_name: "あああ")
      address.valid?
      expect(address).to be_valid
    end

    it "sendfirst_name_kanaが全角カタカナで返ること" do
      address = build(:address, sendfirst_name_kana: "あああ")
      address.valid?
      expect(address.errors[:sendfirst_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it "sendfirst_name_kanaが全角カタカナで返ること、成功" do
      address = build(:address, sendfirst_name_kana: "アアア")
      address.valid?
      expect(address).to be_valid
    end

    it "sendlast_name_kanaが全角カタカナで返ること" do
      address = build(:address, sendlast_name_kana: "あああ")
      address.valid?
      expect(address.errors[:sendlast_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it "sendlast_name_kanaが全角カタカナで返ること、成功" do
      address = build(:address, sendlast_name_kana: "アアア")
      address.valid?
      expect(address).to be_valid
    end

    it "postal_codeが、ハイフン無しの数字で返ること" do
      address = build(:address, postal_code: "111-1111")
      address.valid?
      expect(address.errors[:postal_code]).to include("はハイフン無しの7桁の数字で入力して下さい")
    end

    it "postal_codeが、ハイフン無しの7桁の数字で返ること、成功" do
      address = build(:address, postal_code: "1111111")
      address.valid?
      expect(address).to be_valid
    end

    it "postal_codeが、7桁の数字で返ること" do
      address = build(:address, postal_code: "111111")
      address.valid?
      expect(address.errors[:postal_code]).to include("はハイフン無しの7桁の数字で入力して下さい")
    end

    it "postal_codeが、7桁の数字で返ること、成功" do
      address = build(:address, postal_code: "1111111")
      address.valid?
      expect(address).to be_valid
    end
  end
end



