FactoryGirl.define do
  factory :reverification_tracker do
    status 0
    created_at DateTime.now.utc
    updated_at DateTime.now.utc
  end
end
