# frozen_string_literal: true

module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      private

      def resource_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
