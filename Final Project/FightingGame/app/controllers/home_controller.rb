class HomeController < ApplicationController
  def show
    if current_user
      @heros = current_user.heros.all
    end
  end
end
