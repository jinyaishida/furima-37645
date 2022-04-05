class Item < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  validates_numericality_of :price, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999
  validates :shipping_method_id, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_area_id, presence: true
  validates :description, presence: true
  validates :shipping_date_id, presence: true
  validates :user, presence: true

  validates :category_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :shipping_area_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :shipping_date_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :shipping_method_id, numericality: { other_than: 1, message: "can't be blank"}

 belongs_to :user
 has_one_attached :image

 extend ActiveHash::Associations::ActiveRecordExtensions
 belongs_to :category
 belongs_to :condition
 belongs_to :shipping_area
 belongs_to :shipping_date
 belongs_to :shipping_method

end
