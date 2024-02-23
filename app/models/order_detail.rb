class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  # 要件定義　making status 制作不可:0 制作待ち:1 制作完了:2 config/locales/ja.ymlにも同様の記述
  # editにwaiting_manufacturreの同様の記述

  enum making_status: { impossible: 0, waiting_manufacture: 1, in_making: 2,finish: 3 }
end
