# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      private

      def sign_up_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender)
      end
    end
  end
end
