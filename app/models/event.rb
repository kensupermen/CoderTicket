class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
    Event.where("ends_at > ?", Time.now )
  end

  def self.published
    @events = Event.all.where.not(published_at: nil)
  end

  def self.search_by_name(name)
    where("lower(name) LIKE ?", "%#{name.downcase}%")
  end

  def is_out_of_date?
    starts_at < Time.now
  end

  def venue_name
    venue ? venue.name : nil
  end

end
