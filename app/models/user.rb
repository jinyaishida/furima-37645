class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :birthday, presence: true
  validates :first_name,:last_name, format: {with:/\A[ぁ-んァ-ン一-龥]/,message: 'Full-width characters'}
  validates :first_name_kana,:last_name_kana, format: {with: /\A[ァ-ヶー－]+\z/,message: 'Full-width katakana characters'}
end
