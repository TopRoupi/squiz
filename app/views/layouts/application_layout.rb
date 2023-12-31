# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout

  def template(&block)
    doctype

    html do
      head do
        title { "You're awesome" }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag "application", data_turbo_track: "reload"
        action_cable_meta_tag
        unsafe_raw helpers.vite_client_tag
        unsafe_raw helpers.vite_javascript_tag("application")
      end

      body class: "p-10" do
        div class: "m-auto", style: "max-width: 700px;" do
          main(&block)
        end
      end
    end
  end
end
