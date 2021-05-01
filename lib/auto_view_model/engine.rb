# frozen_string_literal: true

require "rails"

require_relative "template_patch"

module AutoViewModel
  class Engine < Rails::Engine
    initializer :set_view_autoload_path, before: :set_load_path do |app|
      app.config.autoload_paths += [app.root.join("app/views").to_s]
    end

    initializer "auto_view_model.monkey_patch" do |app|
      ActiveSupport.on_load(:action_view) do

        ActionView::Template.prepend(AutoViewModel::TemplatePatch)
      end
    end
  end
end
