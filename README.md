users テーブル
| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| read_name_last     | string | null: false               |
| read_name_first    | string | null: false               |
| birthday           | date   | null: false               |

.association
has_many : items
has_many : orders

items テーブル
| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| item_name        | string     | null: false                    |
| item_price       | integer    | null: false                    |
| category_id      | integer    | null: false                    |
| item_status_id   | integer    | null: false                    |
| cost_id          | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| item_info        | text       | null: false                    |
| aim_id           | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

.association
belongs_to : user
has_one : order

orders テーブル
| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

.association
belongs_to : user
belongs_to : item
has_one : address


addresses テーブル
| Column        | Type       | Options                        |
|-------------- |------------|--------------------------------|
| postcode      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building      | string     |                                |
| telephone     | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

.association
belongs_to : order