class Relative < ApplicationRecord

    #DescendantBranch Join
    has_many :descendant_branches, :foreign_key => :parent_id, :dependent => :destroy
    has_many :reverse_descendant_branches, :class_name => :DescendantBranch, :foreign_key => :child_id, :dependent => :destroy
    has_many :relatives, :through => :descendant_branches, :source => :child

    #MarriageBranch Join
    has_many :marriage_branches, :foreign_key => :wife_id, :dependent => :destroy
    has_many :reverse_marriage_branches, :class_name => :MarriageBranch, :foreign_key => :husband_id, :dependent => :destroy
    has_many :relatives, :through => :marriage_branches, :source => :husband

    #CarrierWave, :photograph is really an image, use the ImageUploader
    # REMINDER-- THIS IS NOT AT ALL CONNECTED TO THE PHOTO TABLE. IT PROBABLY SHOULD BE BUT ISN'T CURRENTLY
    # IF I WANT TO DO THAT LATER, ADD A FOREIGN KEY AND A ROUTE/VIEW FOR SELECTING AN IMAGE
    mount_uploader :profile_photo, ImageUploader

    #Connection to Photos for photo tagging
    has_many :photo_tags
    has_many :photos, :through => :photo_tags

    #Connection to Memories for memory tagging
    has_many :memory_tags
    has_many :memories, :through => :memory_tags

    #Connection to Event for moment tagging
    has_many :event_tags
    has_many :events, :through => :event_tags

    #instance methods (by default?)

    #CALLED WHEN A RELATIVE IS CREATED
    def create_birth_event_and_tags
        birth_event = Event.create!({ :when => self.birthday,
                        :content => self.get_birth_event_content,
                        :event_type => "birth",
                        :event_type_reference => self.id})

        parents = self.find_parent_relatives
        if birth_event #this should always be true
            EventTag.create!({:event_id => birth_event.id,
                              :relative_id => self.id})
            #add birth event to parents
            parents.each do |parent|
                EventTag.create!({:event_id => birth_event.id,
                                  :relative_id => parent.id})
            end
        end

    end

    #CALLED WHEN A RELATIVE IS CREATED OR WHEN A DEATHDAY IS ADDED (VIA UPDATE)
    def create_death_event_and_tags
        if self.deathday
            death_event = Event.create!({ :when => self.deathday,
                            :content => self.get_death_event_content,
                            :event_type => "death",
                            :event_type_reference => self.id})
            parents = self.find_parent_relatives
            children = self.find_child_relatives
            spouses = self.find_spouse_relatives

            #tag for self
            EventTag.create!({:event_id => death_event.id,
                              :relative_id => self.id})
            parents.each do |parent|
                if self.diedBefore(parent)
                    EventTag.create!({:event_id => death_event.id,
                                      :relative_id => parent.id})
                end
            end
            children.each do |child|
                if self.diedBefore(child)
                    EventTag.create!({:event_id => death_event.id,
                                      :relative_id => child.id})
                end
            end
            spouses.each do |spouse|
                if self.diedBefore(spouse)
                    EventTag.create!({:event_id => death_event.id,
                                      :relative_id => spouse.id})
                end
            end
        end
    end

    #CALLED WHEN A RELATIVE IS CREATED
    # def create_birth_event_tags
    #     birth_event = Event.find_by(:event_type_reference => self.id,
    #                                 :event_type => "birth")
    #     # parents = self.find_parent_relatives
    #     # if birth_event #this should always be true
    #     #     EventTag.create!({:event_id => birth_event.id,
    #     #                       :relative_id => self.id})
    #     #     #add birth event to parents
    #     #     parents.each do |parent|
    #     #         EventTag.create!({:event_id => birth_event.id,
    #     #                           :relative_id => parent.id})
    #     #     end
    #     # end
    #
    # end

    # #CALLED WHEN A RELATIVE IS CREATED OR WHEN A DEATHDAY IS ADDED (VIA UPDATE)
    # def create_death_event_tags
    #
    #     death_event = Event.find_by(:event_type_reference => self.id,
    #                                 :event_type => "death")
    #
    #     parents = self.find_parent_relatives
    #     children = self.find_child_relatives
    #     spouses = self.find_spouse_relatives
    #
    #     if death_event # this may or may not be true
    #         EventTag.create!({:event_id => death_event.id,
    #                           :relative_id => self.id})
    #         parents.each do |parent|
    #             if self.diedBefore(parent)
    #                 EventTag.create!({:event_id => death_event.id,
    #                                   :relative_id => parent.id})
    #             end
    #         end
    #         children.each do |child|
    #             if self.diedBefore(child)
    #                 EventTag.create!({:event_id => death_event.id,
    #                                   :relative_id => child.id})
    #             end
    #         end
    #         spouses.each do |spouse|
    #             if self.diedBefore(spouse)
    #                 EventTag.create!({:event_id => death_event.id,
    #                                   :relative_id => spouse.id})
    #             end
    #         end
    #     end
    # end


    #CALLED WHEN A RELATIVE IS UPDATED
    def update_birth_event_and_tags
        #birth_event should exist already
        birth_event = Event.find_by(:event_type_reference => self.id,
                                    :event_type => "birth")
        # only update if data changed
        if (self.birthday != birth_event.when) || (birth_event.content != self.get_birth_event_content)
            birth_event.update(:when => self.birthday, :content => self.get_birth_event_content)
        end

        # tags need to be changed if parents changed
        parent_ids = self.find_parent_relatives.pluck(:id)

        birth_event_tag_ids = EventTags.where(:event_id => birth_event.id).pluck(:relative_id)
        birth_event_tag_ids.delete(self.id) #should leave only parent ids

        unless parent_ids == birth_event_tag_ids # unless parents haven't changed
            # f*** it
            self.destroy_birth_event_and_tags
            self.create_birth_event_and_tags
        end

    end

    #CALLED WHEN A RELATIVE IS UPDATED
    def update_death_event_and_tags
        #death_event may or may not exist already
        death_event = Event.find_by(:event_type_reference => self.id,
                                    :event_type => "death")
        if death_event && !self.deathday #coming back from the dead
            self.destroy_death_event_and_tags
        elsif !death_event && self.deathday #just died
            self.create_death_event_and_tags
        elsif death_event && self.deathday #already dead, just updating dates and tags
            # only update if data changed
            if (self.deathday != death_event.when) || (death_event.content != self.get_death_event_content)
                death_event.update(:when => self.deathday, :content => self.get_death_event_content)
            end

            # tags need to be changed if parents, children, or spouses changed
            parent_ids = self.find_parent_relatives.pluck(:id)
            children_ids = self.find_child_relatives.pluck(:id)
            spouse_ids = self.find_spouse_relatives.pluck(:id)

            relative_ids = parent_ids + children_ids + spouse_ids

            death_event_tag_ids = EventTags.where(:event_id => death_event).pluck(:relative_id)
            death_event_tag_ids.delete(self.id) # should ust be relatives if nothing's changed

            unless relative_ids == death_event_tag_ids # unless parents haven't changed
                # f*** it
                self.destroy_death_event_and_tags
                self.create_death_event_and_tags
            end
        end
    end

    def destroy_death_event_and_tags
        death_event = Event.find_by(:event_type_reference => self.id,
                                    :event_type => "death")

        if death_event
            death_event_tags = EventTag.where(:event_id => death_event.id)
            death_event_tags.destroy_all
            death_event.destroy
        end
    end

    def destroy_birth_event_and_tags
        birth_event = Event.find_by(:event_type_reference => self.id,
                                    :event_type => "birth")
        birth_event_tags = EventTag.where(:event_id => birth_event.id)
        birth_event_tags.destroy_all
        birth_event.destroy
    end

    # => called when relative deleted, destorys tags to events not tethered to this relative's life
    def destroy_all_event_tags
        EventTag.where(:relative_id => self.id).destroy_all
    end


    # COULD I MAKE THESE CONSTANTS OF EVENT? EVENTUALLY?
    def get_birth_event_content
        return "Birth of #{self.first} #{self.surname}"
    end

    def get_death_event_content
        "Death of #{self.first} #{self.surname}"
    end

    # => HELPERS

    def find_parent_relatives
        array_of_parent_ids = self.reverse_descendant_branches.pluck(:parent_id)
        parents = Relative.find(array_of_parent_ids)
        return parents
    end

    def find_child_relatives
        array_of_child_ids = self.descendant_branches.pluck(:child_id)
        children = Relative.find(array_of_child_ids)
        return children
    end

    def find_spouse_relatives #including ex-spouses
        array_of_spouse_ids = nil
        if self.sex == "male"
            array_of_spouse_ids = self.reverse_marriage_branches.pluck(:wife_id)
        else
            array_of_spouse_ids = self.marriage_branches.pluck(:husband_id)
        end
        spouses = Relative.find(array_of_spouse_ids)
        return spouses
    end


    def diedBefore(relative)
        # if only self has died or if self and relative have both died and self died first
        if (self.deathday && !relative.deathday) || ((self.deathday && relative.deathday) && self.deathday < relative.deathday )
            return true
        end
        return false
    end


end
