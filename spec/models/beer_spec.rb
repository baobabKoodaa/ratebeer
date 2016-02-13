require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is not saved without a name" do
    Beer.create style:"Lager"

    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    Beer.create name:"Karhu"

    expect(Beer.count).to eq(0)
  end

  it "is saved with valid name and style" do
    Beer.create name:"Karhu", style:"Lager"

    expect(Beer.count).to eq(1)
    expect(Beer.first.name).to eq("Karhu")
    expect(Beer.first.style).to eq("Lager")
  end

end
