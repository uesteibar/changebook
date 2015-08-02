FactoryGirl.define do
  factory :uesteibar, class: User do
    username 'uesteibar'
    email 'uesteibar@live.com'
    password 'uesteibar'
    password_confirmation 'uesteibar'
    latitude 43
    longitude (-2)
  end

  factory :alaine, class: User do
    username 'alaine'
    email 'alaine@live.com'
    password 'alainealaine'
    password_confirmation 'alainealaine'
    latitude 43
    longitude (-2)
  end

  factory :alen, class: User do
    username 'alenesteibar'
    email 'alenesteibar@live.com'
    password 'alenalen'
    password_confirmation 'alenalen'
    latitude 43
    longitude (-2)
  end
end
