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
                render json: {data: tokenize(user)}, status: 200
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
                    render json: {data: tokenize(userInDB)}, status: 200
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

        def tokenize(payload)
            token = JsonWebToken.encode(payload: payload)
            time = Time.now + 24.hours.to_i 
            return {
                time: time,
                token: token
            }     
        end
    end    
end