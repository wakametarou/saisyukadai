class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  validates :postal_code, :prefecture, :city, :address_number ,presence: true
  validates :sendfirst_name, :sendlast_name ,presence: true,
              format: {
                with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,
                message: "は全角で入力して下さい"
              }
  validates :sendfirst_name_kana, :sendlast_name_kana, presence: true,
              format: {
                with: /\A[ァ-ヶー－]+\z/,
                message: "は全角カタカナで入力して下さい"
              }
  validates :postal_code ,presence: true,
              format: {
                with: /\A\d{7}\z/,
                message: "はハイフン無しの7桁の数字で入力して下さい"
              }
  belongs_to :user, optional: true
end
