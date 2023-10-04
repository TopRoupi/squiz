# frozen_string_literal: true

class Users::RegisterView < ApplicationView
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::Label
  include Phlex::Rails::Helpers::TextField

  def template
    h1 { "Users::Setup" }
    p { "Find me in app/views/users/setup_view.rb" }
    form_with url: "/users/setup", method: :post do |f|
      plain f.label :username, "User Name"
      plain f.text_field :username
      plain f.submit
    end
  end
end
