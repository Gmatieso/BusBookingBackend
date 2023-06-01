class AdminsController < ApplicationController
    #We use controller to map to our routings. 
    before_action :authorize, only: [:show]

    def show
        admin = Admin.find(session[:admin_id])
        if admin
            render json: admin     #Here we just telling our Rails, instead of rendering HTML template, you should send back JSON data as the response. 
        else
            render json: {error: "user not authorized"}, status: :unauthorized
        end
    end

    def signup
        admin = Admin.create(admin_params)
        if admin.valid?
            session[:admin_id] = admin.id
            render json: admin, status: :created
        else
            render json: {errors: admin.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def login
        admin = Admin.find_by(username: params[:username])
        if admin&.authenticate(params[:password])
            session[:admin_id] = admin.id
            render json: admin, status: :created
        else
            render json: {error: "Invalid username or password"}, status: :unauthorized
        end
    end

    def logout
        session.delete :user_id
        head :no_content
    end


    private

    def authorize
        render json: {error: "user not authorized"}, status: :unauthorized unless session.include? :user_id
    end

    def admin_params
        params.permit(:username, :email, :phone_number, :password, :password_confirmation)
    end
end
