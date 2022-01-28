FactoryBot.define do
  factory :order_address do
    postcode {"123-4567"}
    prefecture_id {2}
    city {"東京都"}
    house_number {"1-1"}
    building {'東京ビルディング'}
    telephone {"090-1234-5678"}

  end
end
