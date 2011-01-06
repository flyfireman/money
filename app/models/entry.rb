class Entry < ActiveRecord::Base
  acts_as_paranoid
  acts_as_taggable
  belongs_to :user
end
