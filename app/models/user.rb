class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attachment :photo

  has_many :events, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :run_level, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

end
