class PagesController < ActionController::Base
    def index
        # authorize_request
    end


    private
    def authorize_request
        header = request.headers['x-auth-token']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
          current_user_id = @decoded["id"]
        #   render json: { }, status: 422
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
    end    
end
