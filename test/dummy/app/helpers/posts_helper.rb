module PostsHelper
  def hello(value)
    content_tag :p, "Hello #{value}"
  end
end
