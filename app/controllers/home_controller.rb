class HomeController < ApplicationController
  def index
    @count ||= 0
  end
end
