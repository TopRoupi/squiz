class HomeController < ApplicationController
  def index
    render Home::IndexView.new
  end
end
