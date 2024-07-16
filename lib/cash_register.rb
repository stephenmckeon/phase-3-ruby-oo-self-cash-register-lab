require "pry"

class CashRegister
  attr_reader :discount, :items
  attr_accessor :total

  def initialize(discount=0)
    @discount = discount
    @total = 0
    @items = []
    @last_transaction = {}
  end

  def add_item(title, price, quantity=1)
    item_total = price * quantity

    @total += item_total
    @last_transaction = { title: title, price: price, quantity: quantity }
    quantity.times { @items << title }
  end

  def apply_discount
    return "There is no discount to apply." unless discount.positive?

    @total *= total_percentage
    "After the discount, the total comes to $#{total.to_i}."
  end

  def total_percentage
    1 - discount_percentage
  end

  def discount_percentage
    discount / 100.0
  end

  def void_last_transaction
    remove_from_items
    reduce_total
  end

  def remove_from_items
    @last_transaction[:quantity].times { @items.pop }
  end

  def reduce_total
    @total -= last_transaction_total
  end

  def last_transaction_total
    @last_transaction[:price] * @last_transaction[:quantity]
  end
end
