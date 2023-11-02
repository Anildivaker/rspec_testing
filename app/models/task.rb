class Task < ApplicationRecord
  belongs_to :event, optional: true
end
