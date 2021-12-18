class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname,           presence: true
  validates :encrypted_password,:password_confirmation, format:{ with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i}
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/} do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/} do
    validates :read_name_last
    validates :read_name_first
  end
  
  validates :birthday,           presence: true
end


