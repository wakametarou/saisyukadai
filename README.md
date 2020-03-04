## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association

- has_many :items
- has_many :dealings
- has_one :profile
- has_one :address
- has_many :cards


## profilesテーブル

|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|tell|integer|
|introduce|text|
|avatar|string|
|birthday|date|null: false|
|user|references|null: false, foreign_key: true|

### Association

- belongs_to :user


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|address_number|string|null: false|
|building|string|

### Association

- belongs_to :user



## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|price|integer|null: false|
|detail|text|null: false|
|condition|integer|null: false|
|delivery_tax_payer|integer|null: false|
|delivery_from|integer|null: false|
|delivery_days|integer|null: false|
|category|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association

- has_many :item_images, dependent: :destroy
- has_one :dealing
- belongs_to :user
- belongs_to :category


## item_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item|references|foreign_key: true|

### Association

- belongs_to :item


## categorysテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|ancestry|string|

### Association

- has_many :items


## dealingsテーブル

|Column|Type|Options|
|------|----|-------|
|phase|boolean|defoult: false|
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association

- belongs_to :item
- belongs_to :user


## cardsテーブル

|user|references|null: false, foreign_key: true|
|customer_id|string|

### Association

- belongs_to :user
