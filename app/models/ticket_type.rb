class TicketType < ActiveRecord::Base
  belongs_to :event
  validates_uniqueness_of :name
end
