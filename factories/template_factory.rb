FactoryGirl.define do
  factory :template do
    name { Faker::Name.name }
    type { 'Template' }

    after(:build) { |template| 3.times { template.model_links << FactoryGirl.build(:model_link) } }
  end
end
