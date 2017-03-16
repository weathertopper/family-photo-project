class EventTag < ApplicationRecord
    belongs_to :relative
    belongs_to :event
end
