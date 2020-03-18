## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|

### Association

- has_many :items
- has_many :dealings
- has_one :profile
- has_one :address
- has_many :cards


## profilesテーブル

|Column|Type|Options|
|------|----|-------|
|introduce|text|
|avatar|string|
|user_id|reference|null: false, foreign_key: true|

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
|tell|integer|unique: true|
|user_id|reference|null: false, foreign_key: true|


### Association

- belongs_to :user



## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|price|integer|null: false|
|detail|text|null: false|
|condition|integer|null: false|
|delivery_tax_payer|string|null: false|
|delivery_from|string|null: false|
|delivery_days|string|null: false|
|category_id|string|null: false|
|brand|string|
|user_id|integer|null: false, foreign_key: true|

### Association

- has_many :item_images, dependent: :destroy
- has_one :dealing
- belongs_to :user
- belongs_to :item_category
- belongs_to :item_brand


## item_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|foreign_key: true|

### Association

- belongs_to :item


## item_categorysテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|ancestry|string|

### Association

- has_many :items


## item_brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|

### Association

- has_many :items


## dealingsテーブル

|Column|Type|Options|
|------|----|-------|
|phase|boolean|defoult: false|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :item
- belongs_to :user


## cardsテーブル

|user_id|reference|null: false, foreign_key: true|
|customer_id|string|

### Association

- belongs_to :user
