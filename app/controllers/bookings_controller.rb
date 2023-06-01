class BookingsController < ApplicationController
    #This controller maps to our routings 
rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_record_not_found
wrap_parameters format: []   #Don't wrap JSON  parameters as nested hash 
    
    #Show all bookings 
    def index
        render json: Booking.all, status: :ok
    end

    #Show specific booking here 
    def show
        booking = find_booking
        render json: booking, status: :ok
    end

    #Create new bookings here 
    def create
        booking = Booking.create!(booking_params)
        render json: booking, status: :created
    end

    #Update a specific id 
    def update
        #find 
        booking = find_booking
    if booking 
        #Update 
            booking.update!(booking_params)
            render json: booking, status: :accepted
    end

    end

    #Delete a specific id 
    def destroy
        booking = find_booking 
        booking.destroy
        head :no_content
    end






    
    private

    def find_booking 
        Booking.find(:params[:id])
    end

    #Put your Strong Params Here!
     def booking_params
        params.permit(:from, :to, :date, :no_of_passangers)
    end

    def rescue_from_record_not_found
        render json: {errors: "Booking not found"}, status: :not_found
    end
end
