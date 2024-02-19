class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  has_one_attached :image

  # 消費税計算

  def add_tax_price
    (self.price*1.10).round
  end

  # 商品一覧に関わるバリテーションの設定
  # 商品名　紹介文　価格　写真

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :image, presence: true




end
