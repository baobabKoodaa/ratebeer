require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if API returns no results, user is informed appropriately" do
    city = 'kumpulaxxx'
    allow(BeermappingApi).to receive(:places_in).with(city).and_return(
        [ ]
    )

    visit places_path
    fill_in('city', with: city)
    click_button "Search"

    expect(page).to have_content "No locations in #{city}"
  end

  it "multiple results by API are shown to user" do
    city = 'Puistola'
    allow(BeermappingApi).to receive(:places_in).with(city).and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ),
          Place.new( name:"Nälkäinen Nänni", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: city)
    click_button "Search"

    expect(page).to have_content "Nänni"
    expect(page).to have_content "Oljenkorsi"
  end

end