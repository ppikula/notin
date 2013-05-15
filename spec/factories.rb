require 'faker'

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "arthurdent#{n}@gmail.com"
    end
    provider 'facebook'
    uid '42'
  end

  factory :tag do
    sequence :name do |n|
      "##{n} Tag."
    end
  end

  factory :note do
    sequence :title do |n|
      "##{n} Note."
    end
    sequence :content do
      Faker::Lorem.paragraphs(Random.rand(6) + 1).join('\n\n')
    end
    tag_list 'apollo, zeus'
  end
end

