class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  has_one_attached :item_image
  
  # 商品の税込金額
  def with_tax_price
    (price * 1.1).floor
  end

  # 商品一覧に関わるバリテーションの設定
  # 商品名　紹介文　価格　写真

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :item_image, presence: true
  

end

