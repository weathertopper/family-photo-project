class EventTag < ApplicationRecord
    belongs_to :relative
    belongs_to :event

    validate :no_duplicate_event_tags

    def no_duplicate_event_tags
        already_exists = EventTag.where(:event_id => event_id).where(:relative_id => relative_id)
        if already_exists.count > 0
            errors.add(:relative_id, "Don't tag a relative in this event twice!")
        end
    end

end
