class ClientsController < ApplicationController
    #Transmits data requests from the user to the model, and then delivers data  that is rendered in the view to the user 
    before_action :authorize, only: [:show]

    def show
        #find 
        client = Client.find_by(id:session[:client_id])
        if client
            render json: client
        else
            render json: {error: "user not authorized"}, status: :unauthorized
        end
    end

    def signup
        client = Client.create(client_params)
        if client.valid?
            session[:client_id] = client.id
            render json: client, status: :created
        else
            render json: {errors: client.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def login
        client = Client.find_by(username: params[:username])
        if client&.authenticate(params[:password])
            session[:client_id] = client.id
            render json: client, status: :created
        else
            render json: {error: "Invalid username or password"}, status: :unauthorized
        end
    end

    def logout
        session.delete :client_id
        head :no_content
    end


    private

    def authorize
        render json: {error: "user not authorized"}, status: :unauthorized unless session.include? :user_id
    end

    def client_params
        params.permit(:username, :email, :phone_number, :password, :password_confirmation)
    end
end
