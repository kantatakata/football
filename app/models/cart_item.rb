class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
# 　一意性制約：customer_id
  validates :item_id, uniqueness: { scope: :customer_id }
  # 数値のバリデーション
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }

  def subtotal
    item.with_tax_price * amount
  end
  

end
