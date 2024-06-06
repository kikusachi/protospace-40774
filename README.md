## usersテーブル

| Column              | Type       | Options                   |
| ------------------- | ---------- | ------------------------- |
| email               | string     | null: false, unique: true |
| encrypted_password  | string     | null: false               |
| name                | string     | null: false               |
| profile             | text       | null: false               |
| occupation          | text       | null: false               |
| position            | text       | null: false               |

## commentsテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false                    |
| phototype | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

## prototypesテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| title      | string     | null: false                    |
| catch_copy | text       | null: false                    |
| concept    | text       | null: false                    |
| user       | references | null: false, foreign_key: true |