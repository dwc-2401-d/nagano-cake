class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  # 要件定義　statusの情報表示の為　入金待ち:0 入金確認:1 制作中:2 発送準備:3 発送済み:4 config/locales/ja.ymlにも同様の記述
  # editのwait_paymentに同様の記述

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: {
    wait_payment: 0,
    confirm_payment: 1,
    making: 2,
    preparing_ship: 3,
    finish_prepara: 4
  }
  
end
