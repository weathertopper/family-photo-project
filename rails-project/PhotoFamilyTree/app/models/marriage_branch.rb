class MarriageBranch < ApplicationRecord
    belongs_to :husband, :class_name => Relative
    belongs_to :wife, :class_name => Relative
    validates :anniversary, presence: true
    validate :verify_foreign_keys_exist, :anniversary_before_marriage_end, :marriage_before_deaths, :no_marriages_outstanding

    def verify_foreign_keys_exist
        if wife_id.blank?
            errors.add(:wife, " not selected!")
        end
        if husband_id.blank?
            errors.add(:husband, " not selected!")
        end
    end

    def anniversary_before_marriage_end
        if anniversary.blank? #caught by validation, error will be added there
            return
        end
        if marriage_end
            if marriage_end < anniversary
                # marriage ended before it began (literally)
                errors.add(:marriage, " ended before it began (literally)!")
            end
        end
    end

    def marriage_before_deaths
        if anniversary.blank? #caught by validation, error will be added there
            return
        end
        if husband_id && wife_id
            husband = Relative.find(husband_id)
            wife = Relative.find(wife_id)

            if husband.deathday && anniversary > husband.deathday
                errors.add(:husband, " can't be married, he's dead!")
            end

            if wife.deathday && anniversary > wife.deathday
                errors.add(:wife, " can't be married, she's dead!")
            end
        end
    end

    def no_marriages_outstanding
        if anniversary.blank? #caught by validation, error will be added there
            return
        end
        if husband_id && wife_id
            husband_marriages = MarriageBranch.where(:husband_id => husband_id)
            wife_marriages = MarriageBranch.where(:wife_id => wife_id)

            husband_marriages.each do |marriage|
                if id && id == marriage.id
                    #if updating && come upon yourself, skip
                    next
                end
                if marriage.marriage_end
                    if anniversary > marriage.anniversary && anniversary < marriage.marriage_end
                        # if new marriage started in the middle of a previous marriage (that eventually ended)
                        errors.add(:husband_id, " is already married during this time!")
                    end

                    if marriage_end && marriage_end >= marriage.anniversary && anniversary <=marriage.marriage_end
                        # if new marriage ended in the middle of a previous marriage (that eventually ended)
                        errors.add(:husband_id, " is already married during this time!")
                    end
                else #there's a current marriage, so this new marriage better have ended before the current marriage!
                    if marriage_end
                        #this new marriage ended during the current marriage
                        if marriage_end > marriage.anniversary
                            errors.add(:husband_id, " is already married during this time!")
                        end
                    else
                        #this new marriage would be the second current marriage
                        errors.add(:husband_id, " is already married during this time!")
                    end
                end
            end

            wife_marriages.each do |marriage|
                if id && id == marriage.id
                    #if updating && come upon yourself, skip
                    next
                end
                if marriage.marriage_end
                    if anniversary > marriage.anniversary && anniversary < marriage.marriage_end
                        # if new marriage started in the middle of a previous marriage (that eventually ended)
                        errors.add(:wife_id, " is already married during this time!")
                    end

                    if marriage_end && marriage_end >= marriage.anniversary && anniversary <=marriage.marriage_end
                        # if new marriage ended in the middle of a previous marriage (that eventually ended)
                        errors.add(:wife_id, " is already married during this time!")
                    end
                else #there's a current marriage, so this new marriage better have ended before the current marriage!
                    if marriage_end
                        #this new marriage ended during the current marriage
                        if marriage_end > marriage.anniversary
                            errors.add(:wife_id, " is already married during this time!")
                        end
                    else
                        #this new marriage would be the second current marriage
                        errors.add(:wife_id, " is already married during this time!")
                    end
                end
            end
        end
    end

    # => adding functions for marriage branch to trigger Event & EventTag creation/deletion
    # => (for both marriage_start and marriage_end events)

    #CALLED WHEN A RELATIVE IS CREATED
    def create_anniversary_event_and_tags

        anniversary_event = Event.create!({ :when => self.anniversary,
                        :content => self.get_annivesary_event_content,
                        :event_type => "marriage_start",
                        :event_owner_id => self.id})

        EventTag.create!({:event_id => anniversary_event.id,
                          :relative_id => self.husband_id})
        EventTag.create!({:event_id => anniversary_event.id,
                          :relative_id => self.wife_id})

    end

    #CALLED WHEN A RELATIVE IS CREATED OR WHEN A DEATHDAY IS ADDED (VIA UPDATE)
    def create_marriage_end_event_and_tags
        if self.marriage_end
            marriage_end_event = Event.create!({ :when => self.marriage_end,
                                                :content => self.get_marriage_end_event_content,
                                                :event_type => "marriage_end",
                                                :event_owner_id => self.id})

            EventTag.create!({:event_id => marriage_end_event.id,
                              :relative_id => self.husband_id})
            EventTag.create!({:event_id => marriage_end_event.id,
                              :relative_id => self.wife_id})

        end
    end

    #CALLED WHEN A MARRIAGE IS UPDATED
    def update_anniversary_event_and_tags
        #anniversary_event should exist already
        anniversary_event = Event.find_by(  :event_type => "marriage_start",
                                            :event_owner_id => self.id)

        anniversary_event.update(:when => self.anniversary, :content => self.get_annivesary_event_content)

        # since there are only two tags (husband and wife), just delete them and remake them
        EventTag.where(:event_id => anniversary_event.id).destroy_all
        EventTag.create!({:event_id => anniversary_event.id,
                          :relative_id => self.husband_id})
        EventTag.create!({:event_id => anniversary_event.id,
                          :relative_id => self.wife_id})
    end

    #CALLED WHEN A MARRIAGE IS UPDATED
    def update_marriage_end_event_and_tags
        #marriage_end_event may or may not exist already
        marriage_end_event = Event.find_by(  :event_type => "marriage_end",
                                            :event_owner_id => self.id)

        if marriage_end_event && !self.marriage_end #marriage losing its end date
            self.destroy_marriage_end_event_and_tags
        elsif !marriage_end_event && self.marriage_end #marriage just ended
            self.create_marriage_end_event_and_tags
        elsif marriage_end_event && self.marriage_end #marriage already ended, just updating dates and tags

            marriage_end_event.update(:when => self.marriage_end,
                                      :content => self.get_marriage_end_event_content)

            # since there are only two tags (husband and wife), just delete them and remake them
            EventTag.where(:event_id => marriage_end_event.id).destroy_all
            EventTag.create!({:event_id => marriage_end_event.id,
                              :relative_id => self.husband_id})
            EventTag.create!({:event_id => marriage_end_event.id,
                              :relative_id => self.wife_id})

        end
    end

    def destroy_marriage_end_event_and_tags
        marriage_end_event = Event.find_by(  :event_type => "marriage_end",
                                            :event_owner_id => self.id)
        if marriage_end_event
            marriage_end_event_tags = EventTag.where(:event_id => marriage_end_event.id)
            marriage_end_event_tags.destroy_all
            marriage_end_event.destroy
        end
    end

    def destroy_anniversary_event_and_tags
        anniversary_event = Event.find_by(:event_owner_id => self.id,
                                        :event_type => "marriage_start")
        anniversary_event_tags = EventTag.where(:event_id => anniversary_event.id)
        anniversary_event_tags.destroy_all
        anniversary_event.destroy
    end

    def get_annivesary_event_content
        husband_name = Relative.find(self.husband_id).name_for_display
        wife_name = Relative.find(self.wife_id).name_for_display
        return "#{husband_name} and #{wife_name} married"
    end

    def get_marriage_end_event_content
        husband_name = Relative.find(self.husband_id).name_for_display
        wife_name = Relative.find(self.wife_id).name_for_display
        return "#{husband_name} and #{wife_name} marriage ended"
    end

end
