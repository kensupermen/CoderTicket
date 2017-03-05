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


  describe "search" do

    it "return [] when there are no match event" do
      y = Event.create!(name: "xyzayy", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: "a past event", venue: Venue.new, category: Category.new)
      expect(Event.search_by_name("test")).to eq []
    end

    it "return one when there are one event match" do
      y = Event.create!(name: "xyzayy", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: "a past event", venue: Venue.new, category: Category.new)
      expect(Event.search_by_name("xyzayy")).to eq [y]
    end
  end

  describe ".is_out_of_date?" do
    it "should return true if start date of event is in the past" do
      @event = Event.new(starts_at: 1.days.ago)
      puts "===> a: #{(@event.starts_at < Time.now).inspect}"
      expect(@event.is_out_of_date?).to eq true
    end

    it "should return false if start date of event isn't start " do
      @event = Event.new(starts_at:  Time.now.tomorrow)
      puts "===> a: #{(@event.starts_at > Time.now).inspect}"
      expect(@event.is_out_of_date?).to eq false
    end
  end

  describe "#venue_name" do
    it "returns nil if there's no venue" do
      nil_event = Event.new
      expect(nil_event.venue_name).to be_nil
    end

    it "should returns venue's name if there's a venue"  do
      @event = Event.new
      @event.venue = Venue.new(name: "RMIT")
      expect(@event.venue_name).to eq 'RMIT'
    end
  end

end
