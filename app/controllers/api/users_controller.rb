module Api 
    class UsersController < ActionController::Base
        protect_from_forgery with: :null_session
        
        def index
            users = User.all
            render json: UserSerializer.new(users).serialized_json
        end

        def create
            user = User.new(user_params)
            user['password'] = BCrypt::Password.create(user['password'])

            if user.save
                render json: UserSerializer.new(user).serialized_json
            else
                render json: {error: user.errors.messages }, status: 422
            end
        end

        def login
            user = params["user"]
            userInDB = User.where(email: user['email'])
            
            if userInDB
                userInDB = userInDB[0]
                if BCrypt::Password.new(userInDB['password']) == user['password']
                    render json: {msg: "Login Successful" }, status: 200
                else
                    render json: {error: "Invalid password" }, status: 422  
                end
            else
               render json: {error: "User not found" }, status: 422 
            end
        end

        private

        def user_params
            params.require(:user).permit(:name, :email, :password)
        end
    end    
end