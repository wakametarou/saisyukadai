class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :birthday ,presence: true
  validates :first_name, :last_name ,presence: true,
                format: {
                  with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,
                  message: "は全角で入力して下さい"
                }
  validates :first_name_kana, :last_name_kana, presence: true,
                format: {
                  with: /\A[ァ-ヶー－]+\z/,
                  message: "は全角カタカナで入力して下さい"
                }
  validates :password, presence: true, length: { minimum: 7},
                format: {
                  with: /\A[a-z0-9]+\z/i,
                  message: "は半角英数字で入力して下さい"
                }
  has_many :items
  has_many :dealings
  has_one :profile
  has_one :address
  has_many :cards
end
