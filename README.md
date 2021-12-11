users テーブル
| Column             | Type   | Options     |
|--------------------|--------|-------------|
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| read_name(last)    | string | null: false |
| read_name(first)   | string | null: false |
| birth_date         | string | null: false |

.association
has_many items
has_many buys

items テーブル
| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| item_name  | string     | null: false                    |
| item_price | integer    | null: false                    |
| category   | string     | null: false                    |
| situation  | text       | null: false                    |
| load       | string     | null: false                    |
| seller     | string     | null: false                    |
| area       | string     | null: false                    |
| explain    | text       | null: false                    |
| aim        | text       | null: false                    |
| user       | references | null: false, foreign_key: true |

.association
belongs_to user
has_one buy

buys テーブル
| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

.association
belongs_to item
has_one address

addresses テーブル
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| postal_code  | string     | null: false                    |
| town         | string     | null: false                    |
| city         | string     | null: false                    |
| house_number | string     | null: false                    |
| building     | string     |                                |
| telephone    | string     | null: false                    |
| user         | references | null: false, foreign_key: true |

.association
belongs_to buy