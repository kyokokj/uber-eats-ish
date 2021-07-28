class Order < ApplicationRecord
  has_many :orderings

  validates :total_price, numericality: { greater_than: 0 }

  def save_with_update_orderings!(orderings)
    ActiveRecord::Base.transaction do
      orderings.each do |ordering|
        ordering.update_attributes!(active: false, order: self)
      end
      self.save!
    end
  end
end
