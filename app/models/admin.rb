class Admin < ApplicationRecord
    #They communicate with the the Database via active Record 
    has_many :routes
    
    has_secure_password
    validates :username, presence: true, uniqueness: {case_sensitive: true}
end
