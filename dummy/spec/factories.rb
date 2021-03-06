def r_str
  SecureRandom.hex(3)
end

def resource_has_many(resource, association_name)
  association = if resource.send(association_name).length > 0
    nil
  elsif association_name.to_s.classify.constantize.count > 0
    association_name.to_s.classify.constantize.last
  else
    Factory.create association_name.to_s.singularize.to_sym
  end
  
  resource.send(association_name).send('<<', association) if association
end

FactoryGirl.define do
  Voluntary::Test::RspecHelpers::Factories.code.call(self)
  
  factory :community do
    association :organization
    sequence(:name) { |n| "Community #{n}" }
    sequence(:text) { |n| "Text #{n}" }
  end
  
  factory :feedback do
    association :community
    association :user
    feedback_type 'Problem'
    sequence(:name) { |n| "Feedback #{n}" }
    sequence(:text) { |n| "Text #{n}" }
  end
end