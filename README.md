# FilterableAttributes

When using [ActiveModelSerializers](https://github.com/rails-api/active_model_serializers), filter out attributes values instead of writing a ton of conditionals to change them.

## Usage

```ruby 
class ProductSerializer < ApplicationSerializer 
  include ActiveModelSerializers::FilterableAttributes
  attributes :id, :price_in_cents
  filter_attribute :price_in_cents, unless: :user_signed_in? do
    "Sign in to see the price"
  end 

  private 
  def user_signed_in?
    scope.nil? 
  end
end

product = Product.find(params[:id])
render json: ProductSerializer.new(product, scope: current_user).to_json 
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'filterable_attributes'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install filterable_attributes

## Usage

1. Add `include ActiveModelSerializers::FilterableAttributes` to your serializer
2. Use `filter_attribute :price_in_cents` or `filter_attributes :price_in_cents, :tax_in_cents` followed by options 
3. Enjoy not having a mess of conditionals 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshmn/filterable_attributes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/filterable_attributes/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
