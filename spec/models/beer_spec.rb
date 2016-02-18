require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is not saved without a name" do
    Beer.create

    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    Beer.create name:"Karhu"

    expect(Beer.count).to eq(0)
  end

  it "is saved with valid name and style" do
   FactoryGirl.create :beer

    expect(Beer.count).to eq(1)
    expect(Beer.first.name).to eq("anonymous")
    expect(Beer.first.style.name).to eq("Lager")
  end

end
