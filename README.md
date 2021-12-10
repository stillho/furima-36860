users テーブル
| Column             | Type   | Options     |
|--------------------|--------|-------------|
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| birthday           | string | null: false |

.association
has_many items
has_many buys

items テーブル
| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| item_name  | string     | null: false                    |
| item_price | string     | null: false                    |
| category   | string     | null: false                    |
| situation  | text       | null: false                    |
| load       | string     | null: false                    |
| seller     | string     | null: false                    |
| area       | string     | null: false                    |
| explain    | text       | null: false                    |
| aim        | text       | null: false                    |
| comment    | text       | null: false                    |
| user       | references | null: false, foreign_key: true |

.association
belongs_to users
has_one buys

buys テーブル
|Column|Type|Options|
|------|----|-------|
| user       | references | null: false, foreign_key: true |
| item_name  | references | null: false, foreign_key: true |
| total      | string     | null: false,                   |

.association
belongs_to items
has_many address

address テーブル
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| postal_code  | string     | null: false                    |
| town         | string     | null: false                    |
| city         | text       | null: false                    |
| house_number | text       | null: false                    |
| building     | text       | none                           |
| telephone    | string     | null: false                    |
| user         | references | null: false, foreign_key: true |

.association
belongs_to buys