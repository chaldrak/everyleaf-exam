class User < ApplicationRecord
    validates :name, presence: true, length: {in: 1..30}
    validates :email, presence: true, uniqueness: true, length: {maximum: 255},
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation {email.downcase!}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}
    has_many :tasks, dependent: :destroy
    before_destroy :check_if_admin, prepend: true

    private
    def check_if_admin
        if self.is_admin
            throw :abort
        end
    end

end
