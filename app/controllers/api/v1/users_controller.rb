module Api
  module V1
    class UsersController < ApplicationController
      # The following line forces authentication for all of the following actions
      # You may want to limit that to specific actions with only: [:action_name_1, :action_name_2] as an argument
      before_filter :authenticate

      def index
        # This is probably dangerous without a serializer as it will return sensitive information
        render json: User.all, status: :ok
      end

      def show
        # This is probably dangerous without a serializer as it will return sensitive information
        @user = User.find(params[:id])
        render json: @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user
        else
          render json: {message: 'failed', status: 500}
        end
      end

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :token)
      end


    end
  end
end
