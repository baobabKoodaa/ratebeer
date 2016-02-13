require 'rails_helper'

describe "Ratings page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  it "shows ratings and their count" do
    user.ratings << FactoryGirl.create(:rating)
    user.ratings << FactoryGirl.create(:rating2)
    visit ratings_path
    expect(page).to have_content("2") #ratingien lkm
    expect(page).to have_content("10") #score rating1
  end

end