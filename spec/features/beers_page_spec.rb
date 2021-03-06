require 'rails_helper'

describe "Beers page" do
  before :each do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
    visit beers_path
  end


  it "allows user to create a valid beer" do
    click_link "New Beer"
    fill_in('beer[name]', with:'Testikalja')
    select('Lager', from: 'beer[style_id]')


    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "does not allow user to create an invalid beer #no_love_for_invalids" do
    click_link "New Beer"
    fill_in('beer[name]', with:'')
    select('Lager', from: 'beer[style_id]')
    click_button "Create Beer"
    expect(page).to have_content("must not be empty")
    expect(Beer.count).to eq(0)
  end

end