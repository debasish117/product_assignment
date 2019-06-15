class User < ApplicationRecord
  ROLES = ["admin", "customer"]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login

  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  User::ROLES.each do |attr|
    define_method :"#{attr}?" do
      attr == role
    end
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
   if login = conditions.delete(:login)
     # where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
     where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
   elsif conditions.has_key?(:username) || conditions.has_key?(:email)
     conditions[:email].downcase! if conditions[:email]
     where(conditions.to_h).first
     # where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
   end
  end

end
