# frozen_string_literal: true

require "test_helper"

class AutoViewModelTest < ActionView::TestCase
  def test_renders_basic_view
    output = render "posts/post", title: "hello world"

    assert_includes output, "<h1>hello world</h1>"
  end

  def test_raises_if_required_argument_is_missing
    exception = assert_raises ActionView::Template::Error do
      render "posts/post"
    end

    assert_match(/Missing view keyword argument :title/, exception.message)
  end

  def test_default_values
    output = render "posts/post", title: "hello world"

    assert_includes output, "<p>Welcome!</p>"
  end

  def test_override_default_values
    output = render "posts/post", title: "hello world", subtitle: "on Rails!"

    assert_includes output, "<p>on Rails!</p>"
  end

  def test_form_helpers
    output = render "posts/form", post: OpenStruct.new(name: "foo")

    assert_match(/<form/, output)
    assert_match(/<label.*input.*value="foo".*name="post\[name\]"/, output)
  end

  def test_application_helpers
    output = render "posts/hello", value: "WORLD"

    assert_match(/<p>Hello WORLD<\/p>/, output)
  end
end
