# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  is_public              :boolean          default(TRUE), not null
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          authentication_keys: [:login]
          attr_writer :login
  validates_uniqueness_of :email
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :posts
  has_many :bonds

  has_many :followings,
  -> { Bond.following },
  through: :bonds,
  source: :friend

  has_many :follow_requests,
  -> { Bond.requesting },
  through: :bonds,
  source: :friend
  has_many :inward_bonds,class_name: "Bond",foreign_key: :friend_id

  has_many :followers,-> { Bond.following },
  through: :inward_bonds,
  source: :user

  before_save :ensure_proper_name_case
  
  def login
    @login || username || email
  end

  def self.find_authenticatable(login)
    where("username = :value OR email = :value", value: login).first
  end

  def self.find_for_database_authentication(conditions)
    conditions = conditions.dup
    login = conditions.delete(:login).downcase
    find_authenticatable(login)
  end

  private
    def ensure_proper_name_case
      self.first_name = first_name.capitalize
    end
end
