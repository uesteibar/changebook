FactoryGirl.define do
  factory :uesteibar, class: User do
    username 'uesteibar'
    email 'uesteibar@live.com'
    password 'uesteibar'
    password_confirmation 'uesteibar'
  end

  factory :alaine, class: User do
    username 'alaine'
    email 'alaine@live.com'
    password 'alainealaine'
    password_confirmation 'alainealaine'
  end

  factory :alen, class: User do
    username 'alenesteibar'
    email 'alenesteibar@live.com'
    password 'alenalen'
    password_confirmation 'alenalen'
  end
end
