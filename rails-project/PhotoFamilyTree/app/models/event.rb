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

    def viable_relatives_to_tag
        relatives = Relative.all
        #remove relatives already tagged
        event_tags = EventTag.where(:event_id => self.id)
        relatives = event_tags.count > 0 ? relatives.where("id NOT IN (?)", event_tags.pluck(:relative_id)) : relatives
        #remove relatives not born yet
        relatives = relatives.where("birthday <= (?)", self.when)
        #remove relatives too dead
        too_dead = relatives.where("deathday < (?)", self.when)
        relatives = too_dead.count > 0 ? relatives.where("id NOT IN (?)", too_dead.pluck(:id)) : relatives

        return relatives
    end

end
