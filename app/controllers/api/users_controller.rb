module Api 
    class UsersController < ActionController::Base
        protect_from_forgery with: :null_session
        
        def index
            users = User.all
            render json: UserSerializer.new(users).serialized_json
        end

        def create
            user = User.new(user_params)

            if user.save
                render json: UserSerializer.new(user).serialized_json
            else
                render json: {error: user.errors.messages }, status: 422
            end
        end

        private

        def user_params
            params.require(:user).permit(:name, :email, :password)
        end
    end    
end