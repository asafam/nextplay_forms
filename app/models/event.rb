# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :string(255)
#  max_questions :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Event < ActiveRecord::Base
  attr_accessible :description, :max_questions, :name, :user_id
end
