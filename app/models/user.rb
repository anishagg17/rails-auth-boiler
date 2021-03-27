class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
  
    # before_create :hash

    # def hash
        # p self.password
        # self.password = hash password
    # end
end
