FactoryBot.define do
  factory :item do
    item_name { '名前' }
    item_info { '説明' }
    item_price { 2000 }
    category_id { 2 }
    item_status_id { 2 }
    cost_id { 2 }
    prefecture_id { 2 }
    aim_id { 2 }
    association :user
  end
end
