FactoryGirl.define do
  factory :year do
    year 2010
  end

  factory :orderer do
  end

  factory :worktype do
  end

  factory :work do
    start_date Time.now
    title 'New Work'
    year
  end

  factory :user do
    email    'testuser@example.com'
    password 'foobarhoge'
  end
end
