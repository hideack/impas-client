# Impas::Client

Impas::Client is a Ruby interface for Impas API.

## Installation

Add this line to your application's Gemfile:

    gem 'impas-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install impas-client

## Usage

```ruby
require 'impas-client'

client = Impas::Client.new({
  #api_url:"http://impas.****.jp/", # デフォルトは http://impas-hideack.sqale.jp
  op_key:"*****"
})

client.add_group "sample_group1"  # 集計グループ追加

client.groups                     # 登録中のグループ一覧取得
=> [{"name"=>"sample_group1", "key"=>"*****"}]

client.add_url(                   # URLを集計対象へ追加
  "*****",
  "http://www.youtube.com/watch?v=2HQkugdXyHY"
)

client.ranking "*****", "tw"            # Twitterツイート数ランキング取得
client.ranking "*****", "fb"            # facebookいいね数ランキング取得
client.ranking "*****", "hatena"        # はてなブックマーク数ランキング取得


# client.delete_group("*****") #集計グループの削除

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
