FactoryGirl.define do
  factory :teacher do
    sequence(:first_name) { |n| "Lauren#{n}"}
    last_name "Imparato"
  end
end
