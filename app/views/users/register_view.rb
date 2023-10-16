# frozen_string_literal: true

class Users::RegisterView < ApplicationView
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::Label
  include Phlex::Rails::Helpers::TextField

  def template
    form_with url: "/users/setup", method: :post do |f|
      h1 class: "header" do
        "User Registration"
      end
      plain f.label :username, "User Name", class: "block mb-2"
      plain f.text_field :username, class: "block border-solid border-2 border-gray-900"
      plain f.submit "Register", class: "btn mt-3"
    end
  end
end
