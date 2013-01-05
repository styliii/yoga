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

  it 'is taggable' do
    teacher = FactoryGirl.create(:teacher)
    teacher.specialty_list = "dharma, assists"
    teacher.specialty_list.should == ["dharma", "assists"]
  end

  it 'can be searched by its tags' do
    teacher1 = FactoryGirl.create(:teacher)
    teacher2 = FactoryGirl.create(:teacher)
    teacher1.specialty_list = "dharma, assists"
    teacher2.specialty_list = "assists, sequencing"

    Teacher.tagged_with(["assists"]).count == 2
  end

  it 'is invalid with a duplicate full name'
  # do
  #   FactoryGirl.create(:teacher, first_name: "Lauren")
  #   FactoryGirl.build(:teacher, first_name: "Lauren").should_not be_valid
  # end

  it 'knows which teachers are the favorite'
  it 'has at least one yoga class that it teaches'

end
