require 'rails_helper'

RSpec.describe Event, type: :model do
  describe ".upcoming" do
    it "return [] when there are no events" do
      expect(Event.upcoming).to eq []
    end
    it "return [] when there are only past events" do
      Event.create!(starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a past event",
                    venue: Venue.new, category: Category.new, name: "abc")
      expect(Event.upcoming).to eq []
    end
    it "return [b] when there are a past event 'a' and a future event 'b'" do
      a = Event.create!(name: "ad", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: "a past event",
                        venue: Venue.new, category: Category.new)
      b = Event.create!(name: "b", starts_at: 2.days.ago, ends_at: 1.day.from_now, extended_html_description: " a future event",
                        venue: Venue.new, category: Category.new)
      expect(Event.upcoming).to eq [b]
    end
  end

  describe "published" do
    it "return [] when there are no published" do 
      x = Event.create!(name: "xyza", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: "a past event", venue: Venue.new, category: Category.new)
      expect(Event.published).to eq []
    end
    it "return events when there are no published" do 
      x = Event.create!(name: "xyzaaaa", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: "a past event", venue: Venue.new, category: Category.new, published_at: Time.now)
      expect(Event.published).to eq [x]
    end

  end
end
