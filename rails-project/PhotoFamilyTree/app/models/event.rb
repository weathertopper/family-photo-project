class Event < ApplicationRecord
    #Connection to Relatives for moment tagging
    has_many :event_tags
    has_many :relatives, :through=> :event_tags
end
