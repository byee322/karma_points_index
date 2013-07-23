# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  first_name         :string(255)      not null
#  last_name          :string(255)      not null
#  username           :string(32)       not null
#  email              :string(255)      not null
#  total_karma_points :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

  def self.by_karma
    self.order('total_karma_points DESC')
  end

  def total_karma
    self.karma_points.sum(:value)
  end

  def self.karma_maker
    User.find_each do |sexy_user|
      puts sexy_user.id
      sexy_user.update_attribute(:total_karma_points, sexy_user.total_karma)
    end
  end

  # def page
  #   @users = User.paginate(:page => params[:page], :per_page => 10)
  # end

  def full_name
    "#{first_name} #{last_name}"
  end
end
