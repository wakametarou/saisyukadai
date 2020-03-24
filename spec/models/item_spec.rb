require 'rails_helper'

describe Item do
  describe '#new' do
    it "写真、商品名、商品の説明、カテゴリー、商品の状態、発送料の負担、発送元の地域、発送日数、価格が入力されていないと保存できません" do
      item = build(:item)
      expect(item).not_to be_valid
    end

   it "写真は空だと保存できません" do
    item = build(:item_image, image: nil)
    item.valid?
    expect(item.errors[:item_image]).not_to include("を選択してください")
  end


  it "商品名が空なら保存できません" do
    item = build(:item, name: nil)
    item.valid?
    expect(item.errors[:name]).to include("を入力してください")
  end

   it "商品の説明が空なら保存できません" do
    item = build(:item, detail: nil)
    item.valid?
    expect(item.errors[:detail]).to include("を入力してください")
   end

    it "カテゴリーが空なら保存できません" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("を選択してください")
  end

  it "商品の状態が空なら保存できません" do
    item = build(:item, condition: nil)
    item.valid?
    expect(item.errors[:condition]).to include("を選択してください")
  end

  it "発送料の負担が空なら保存できません" do
    item = build(:item, delivery_tax_payer: nil)
    item.valid?
    expect(item.errors[:delivery_tax_payer]).to include("を選択してください")
  end

  it "発送元の地域が空なら保存できません" do
    item = build(:item, delivery_from: nil)
    item.valid?
    expect(item.errors[:delivery_from]).to include("を選択してください")
  end

  it "発送日数が空なら保存できません " do
    item = build(:item, delivery_days: nil)
    item.valid?
    expect(item.errors[:delivery_days ]).to include("を選択してください")
  end

  it "価格が空なら保存できません" do
    item = build(:item, price: nil)
    item.valid?
    expect(item.errors[:price]).to include("を入力してください")
  end
  
   it "40字以上は保存できません" do
    item = build(:item, name:"あ" * 41)
    item.valid?
    expect(item.errors[:name]).to include("は40文字以内で入力してください")
   end

  it "40字以下は保存できます" do
    item = build(:item, name: "あ" * 40)
    item.valid?
    expect(item).not_to be_valid
  end

    it "1000文字以上は保存できません" do
    item = build(:item, detail: "あ" * 1001)
    item.valid?
    expect(item.errors[:detail]).to include("は1000文字以内で入力してください")
   end

   it "1000文字以下は保存できます" do
    item = build(:item, detail: "あ" * 1000)
    item.valid?
    expect(item).not_to be_valid
   end

   it "299円より大きかったら保存できる" do
    item = build(:item, price: "299")
    item.valid?
    expect(item.errors[:price]).to include("は299より大きい値にしてください")
   end

   it "10000円より大きかったら保存できない" do
    item = build(:item, price: "10000000")
    item.valid?
    expect(item.errors[:price]).to include("は10000000より小さい値にしてください")
   end
  end
end