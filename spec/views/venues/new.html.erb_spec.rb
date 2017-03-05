require 'rails_helper'
require 'spec_helper'

#RSpec.describe "venues/new.html.erb", type: :view do
feature 'About page' do
  scenario 'visit page create venue' do
    visit  new_venue_path
    expect(page).to have_content 'Name'
    expect(page).to have_content 'Full address'
  end
end
