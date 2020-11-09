class User < ApplicationRecord

    before_create :hash

    def hash
        # self.password = hash password
    end
end
