require 'spec_helper'

describe Teacher do
  it "has a valid factory" do
    FactoryGirl.create(:teacher).should be_valid
  end

  it 'is invalid without a first_name' do
    FactoryGirl.build(:teacher, first_name: nil).should_not be_valid
  end

  it 'has a full name' do
    FactoryGirl.build(:teacher, first_name: "Lauren", last_name: "Imparato").full_name == "Lauren Imparato"
  end

  it 'is invalid with a duplicate full name' do
    FactoryGirl.create(:teacher, first_name: "Lauren")
    FactoryGirl.build(:teacher, first_name: "Lauren").should_not be_valid
  end

  it 'knows which teachers are the favorite'
  it 'has at least one yoga class that it teaches'

end
