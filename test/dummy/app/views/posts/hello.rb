class Posts::Hello < AutoViewModel::Base
  requires :value

  def greeting
    # Call helper in app/helpers/posts_helper.rb
    hello(@value)
  end
end
