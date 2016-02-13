require 'rails_helper'

describe "User page" do
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
    let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
    let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
    let!(:user1) { FactoryGirl.create :user }
    let!(:user2) { FactoryGirl.create :user2 }
    let!(:rating1) { FactoryGirl.create :rating }
    let!(:rating2) { FactoryGirl.create :rating2 }

    before :each do
      beer1.ratings << rating1
      beer2.ratings << rating2
      user1.ratings << rating1
      user1.ratings << rating2
    end

  it "should display user's ratings" do
    visit user_path(user1)
    expect(page).to have_content("10 rating for iso 3")
    expect(page).to have_content("20 rating for Karhu")
  end

  it "should not display other users' ratings" do
    visit user_path(user2)
    expect(page).to_not have_content("10 rating for iso 3")
  end

  it "should allow deleting ratings" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user1)
    save_and_open_page
    array = page.find('delete').first.click
    byebug

  end
end