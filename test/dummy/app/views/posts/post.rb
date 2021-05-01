class Posts::Post < AutoViewModel::Base
  requires :title
  accepts :subtitle, default: "Welcome!"
end
