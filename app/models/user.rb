# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  first_name :string           not null
#  is_public  :boolean          default(TRUE), not null
#  last_name  :string
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :field_name, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :posts
  has_many :bonds 
  has_many :followings,
  -> { where("bonds.state = ?", Bond::FOLLOWING) },
  through: :bonds,
  source: :friend
  has_many :follow_requests,
  -> { where("bonds.state = ?", Bond::REQUESTING) },
  through: :bonds,
  source: :friend
  has_many :inward_bonds,class_name: "Bond",foreign_key: :friend_id
  has_many :followers,-> { where("bonds.state = ?", Bond::FOLLOWING) },through: :inward_bonds,source: :user

  before_save :ensure_proper_name_case
  
  private
    def ensure_proper_name_case
      self.first_name = first_name.capitalize
    end
end
