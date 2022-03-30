# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false, unique: true |
| email              | string  | null: false, unique: true |
| password           | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| birthday           | integer | null: false               |


### Association

- has_many :items
- has_one :purchase

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| price            | integer    | null: false                    |
| shipping_method  | string     | null: false                    |
| user_id          | references | null: false, foreign_key: true |
| category         | string     | null: false                    |
| condition        | string     | null: false                    |
| shipping_area    | string     | null: false                    |
| image            | string     | null: false                    |
| description      | text       | null: false                    |

### Association

- has_one :user
- has_one :shipping

## shipping テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | integer    | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| street        | string     | null: false                    |
| building      | string     | null: false                    |
| phone         | integer    | null: false                    |

### Association

- has_many :items
- has_one :purchase

## purchase テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| card    | integer    | null: false                    |
| user_id | references | null: false, foreign_key: true |


### Association

- has_many :items
- has_one :purchase