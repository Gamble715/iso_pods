class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :pod
end
