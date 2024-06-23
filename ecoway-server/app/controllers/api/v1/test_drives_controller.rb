module Api
  module V1
    class TestDrivesController < ApplicationController
      before_action :authenticate_request!

      def index
        byebug
        favourites = Favourite.find_by(user_id: current_user!.id)

        render json: CarsRepresenter.new(favourites, current_user!.id).as_json
      end

      def create

        test_drive = current_user!.test_drive.new(user_id: params[:user_id], car_id: params[:car_id], phone_number:params[:phone], desired_time: params[:date])
        byebug
        if test_drive.save
          render json: { message: 'Успішно надіслано' }, status: :created
        else
          render json: { error: test_drive.errors.full_messages.first }, status: :unprocessable_entity
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

      def drive_params
          params.require(:test_drive).permit(:phone_number, :desired_time)
      end
    end
  end
end
