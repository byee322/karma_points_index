# == Schema Information
#
# Table name: karma_points
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  value      :integer          not null
#  label      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class KarmaPoint < ActiveRecord::Base
  attr_accessible :user_id, :label, :value
  belongs_to :user

  validates :user, :presence => true
  validates :value, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :label, :presence => true
end
