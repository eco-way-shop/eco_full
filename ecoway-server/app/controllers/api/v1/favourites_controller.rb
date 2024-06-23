module Api
  module V1
    class FavouritesController < ApplicationController
      before_action :authenticate_request!

      def index
        favourites = User.fav_cars(current_user!)

        render json: CarsRepresenter.new(favourites, current_user!.id).as_json
      end

      def create
        favourite = current_user!.favourites.create(car_id: params[:car_id])

        if favourite.save
          render json: { message: 'Успішно додано до вподобаних' }, status: :created
        else
          render json: { error: favourite.errors.full_messages.first }, status: :unprocessable_entity
        end
      end

      def destroy
        favourite = Favourite.find_by(user_id: current_user!.id, car_id: params[:id])

        if favourite
          favourite.destroy
          render json: { message: 'Авто видалено із вподобаних' }
        else
          render json: { message: 'Упс, щось пішло не так' }
        end
      end
    end
  end
end
