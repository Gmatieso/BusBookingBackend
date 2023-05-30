class Booking < ApplicationRecord
    #They communicate with the Database via Active Record 
    #The Logic of our application should mainly reside in the model files 
    belongs_to :client
    belongs_to :bus
end
