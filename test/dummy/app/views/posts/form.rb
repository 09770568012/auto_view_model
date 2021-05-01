class Posts::Form < AutoViewModel::Base
  requires :post

  def post_field(name)
    form_tag "/" do
      label_tag :name do
        text_field :post, :name, value: post.name
      end
    end
  end
end
