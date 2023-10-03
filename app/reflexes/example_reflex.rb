# frozen_string_literal: true

class ExampleReflex < ApplicationReflex
  def do_thing
    @count = element.dataset[:count].to_i + 1
  end
end
