class Event < ApplicationRecord
    #Connection to Relatives for moment tagging
    has_many :event_tags
    has_many :relatives, :through=> :event_tags

    #Validations
    validates :when, presence: true
    validates :content, presence: true

    #CALLED WHEN AN EVENT IS CREATED
    def create_owner_tag
        EventTag.create({:relative_id=> self.event_owner_id, :event_id => self.id})
    end

    def delete_all_tags
        EventTag.where(:event_id => self.id).destroy_all
    end

end
