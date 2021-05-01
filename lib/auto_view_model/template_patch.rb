
module AutoViewModel
  module TemplatePatch
    def locals_code
      class_name = virtual_path.classify
      Object.const_get(class_name)

      "view=#{class_name}.new(local_assigns, view_context: self);"
    rescue NameError
      super
    end
  end
end
