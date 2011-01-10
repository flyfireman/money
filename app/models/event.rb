class Event < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  apply_simple_captcha
end
