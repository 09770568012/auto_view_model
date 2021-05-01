# AutoViewModel

Experimental gem to encapsulate existing partials via sidecar Ruby files.

## Installation

1. Add `auto_view_model` to your Rails application's `Gemfile`.
1. Run `bundle install`.
1. In `config/application.rb`, add `require "auto_view_model/engine"`.
1. Start adding Ruby files to your `views` directory.

## Usage

Using AutoViewModel is simple, create a Ruby file in the same directory as any
partial with a matching name (sans `_` prefix).

e.g.

Given the template `app/views/posts/_post.html.erb`:

```erb
<h1><%= title.upcase %></h1>

<p>
  <%= markdown(body) %>
</p>
```

You would create a sidecar Ruby file: `app/views/posts/post.rb`

```ruby
class Posts::Post < AutoViewModel::Base
  requires :title # Raises if partial is not passed a title
  accepts :body, default: "" # Allows default parameters for non-required attributes

  def title
    @title.upcase
  end

  def rendered_body
    # Application and Rails provided helpers are usable in the view models
    markdown(body)
  end
end
```

And update the template to use the `view` object:

```erb
<h1><%= view.title %></h1>

<p>
  <%= view.rendered_body %>
</p>
```

To render the partial, use `render` like you would any other partial.

```erb
<%= render "posts/post", title: "Hello world", body: "Welcome!" %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BlakeWilliams/auto_view_model.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
