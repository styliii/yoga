require 'spec_helper'
require 'Chronic'

describe YogaClass do
  it 'is not valid if it is a duplicate' do
    yc1 = YogaClass.create(studio_id: Studio.first, teacher_id: Teacher.first, class_date_time: Chronic.parse('today 5pm') )
    yc2 = YogaClass.new(studio_id: Studio.first, teacher_id: Teacher.first, class_date_time: Chronic.parse('today 5pm') )
    yc2.should_not be_valid
  end

  it 'can be created by passing a hash of values' do
    YogaClass.insert_new({:studio => "iamyoustudio",
                                       :teachers_first_name => "Lauren",
                                       :teachers_last_name => "Imparato",
                                       :class_date_time=> Chronic.parse("Today 5pm").to_datetime })

    YogaClass.last.studio == Studio.find_by_name("iamyoustudio")
    YogaClass.last.teacher.first_name == Teacher.find_by_first_name("Lauren")
    YogaClass.last.class_date_time == Chronic.parse("Today 5pm")
  end

  it 'has a valid factory'
  it 'is taggable'
end
