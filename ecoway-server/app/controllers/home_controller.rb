class HomeController < ApplicationController
  def index
    render json: 'Вітаємо в магазині Еко-шлях'
  end
end
