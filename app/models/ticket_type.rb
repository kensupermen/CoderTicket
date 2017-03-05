class TicketType < ActiveRecord::Base
  belongs_to :event
  validates_uniqueness_of :name
   validates :name, presence: true
   validates :price, presence: true, :numericality => true
   validates :max_quantity, presence: true, :numericality => true
end
