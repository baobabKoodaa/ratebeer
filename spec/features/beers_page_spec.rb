require 'rails_helper'

describe "Beers page" do
  before :each do
    visit beers_path
  end


  it "allows user to create a valid beer" do
    click_link "New Beer"
    fill_in('beer[name]', with:'Testikalja')
    select('Lager', from: 'beer[style]')


    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "does not allow user to create an invalid beer #no_love_for_invalids" do
    click_link "New Beer"
    fill_in('beer[name]', with:'')
    select('Lager', from: 'beer[style]')
    click_button "Create Beer"
    expect(page).to have_content("must not be empty")
    expect(Beer.count).to eq(0)
  end

end