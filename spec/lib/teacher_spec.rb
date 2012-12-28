require "spec_helper"
describe Teacher do
  it "has yoga classes" do
    teacher = Teacher.new
    teacher.yoga_classes.count.should > 0
  end
end
