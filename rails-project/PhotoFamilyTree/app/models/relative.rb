class Relative < ApplicationRecord

    #Validations
    validates :first, presence: true
    validates :surname, presence: true
    validates :sex, presence: true
    validates :birthday, presence: true


    #DescendantBranch Join
    has_many :descendant_branches, :foreign_key => :parent_id, :dependent => :destroy
    has_many :reverse_descendant_branches, :class_name => :DescendantBranch, :foreign_key => :child_id, :dependent => :destroy
    has_many :relatives, :through => :descendant_branches, :source => :child

    #MarriageBranch Join
    has_many :marriage_branches, :foreign_key => :wife_id, :dependent => :destroy
    has_many :reverse_marriage_branches, :class_name => :MarriageBranch, :foreign_key => :husband_id, :dependent => :destroy
    has_many :relatives, :through => :marriage_branches, :source => :husband

    #CarrierWave, :photograph is really an image, use the ImageUploadervalidates :name, presence: true
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

    def name_for_display
        if self.nickname != nil && self.nickname != ""
            return "#{self.nickname} #{self.surname}"
        end
        return "#{self.first} #{self.surname}"
    end

    #CALLED WHEN A RELATIVE IS CREATED
    def create_birth_event_and_tags
        birth_event = Event.create!({ :when => self.birthday,
                        :content => self.get_birth_event_content,
                        :event_type => "birth",
                        :event_owner_id => self.id})

        EventTag.create!({:event_id => birth_event.id,
                          :relative_id => self.id})

        parents = self.find_parent_relatives
        parents.each do |parent|
        EventTag.create!({:event_id => birth_event.id,
                          :relative_id => parent.id})
        end
    end

    #CALLED WHEN A RELATIVE IS CREATED OR WHEN A DEATHDAY IS ADDED (VIA UPDATE)
    def create_death_event_and_tags
        if self.deathday
            death_event = Event.create!({ :when => self.deathday,
                            :content => self.get_death_event_content,
                            :event_type => "death",
                            :event_owner_id => self.id})
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

    #CALLED WHEN A RELATIVE IS UPDATED
    def update_birth_event_and_tags
        #birth_event should exist already
        birth_event = Event.find_by(:event_owner_id => self.id,
                                    :event_type => "birth")
        # only update if data changed
        if (self.birthday != birth_event.when) || (birth_event.content != self.get_birth_event_content)
            birth_event.update(:when => self.birthday, :content => self.get_birth_event_content)
        end

        # tags need to be changed if parents changed
        parent_ids = self.find_parent_relatives.pluck(:id)

        birth_event_tag_ids = EventTag.where(:event_id => birth_event.id).pluck(:relative_id)
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
        death_event = Event.find_by(:event_owner_id => self.id,
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

            death_event_tag_ids = EventTag.where(:event_id => death_event).pluck(:relative_id)
            death_event_tag_ids.delete(self.id) # should ust be relatives if nothing's changed

            unless relative_ids == death_event_tag_ids # unless parents haven't changed
                # f*** it
                self.destroy_death_event_and_tags
                self.create_death_event_and_tags
            end
        end
    end

    def destroy_death_event_and_tags
        death_event = Event.find_by(:event_owner_id => self.id,
                                    :event_type => "death")

        if death_event
            death_event_tags = EventTag.where(:event_id => death_event.id)
            death_event_tags.destroy_all
            death_event.destroy
        end
    end

    def destroy_birth_event_and_tags
        birth_event = Event.find_by(:event_owner_id => self.id,
                                    :event_type => "birth")
        birth_event_tags = EventTag.where(:event_id => birth_event.id)
        birth_event_tags.destroy_all
        birth_event.destroy
    end

    # => called when relative deleted, destorys tags to events not tethered to this relative's life
    def destroy_all_event_tags
        EventTag.where(:relative_id => self.id).destroy_all
    end
    # => called when relative deleted
    def destroy_all_photo_tags
        PhotoTag.where(:relative_id => self.id).destroy_all
    end

    # COULD I MAKE THESE CONSTANTS OF EVENT? EVENTUALLY?
    def get_birth_event_content
        return "Birth of #{self.name_for_display}"
    end

    def get_death_event_content
        "Death of #{self.name_for_display}"
    end

    def diedBefore(relative)
        # if only self has died or if self and relative have both died and self died first
        if (self.deathday && !relative.deathday) || ((self.deathday && relative.deathday) && self.deathday < relative.deathday )
            return true
        end
        return false
    end

    # => RELATIVE HELPERS

    # => assume returns <=2 relatives
    def find_parent_relatives
        array_of_parent_ids = self.reverse_descendant_branches.pluck(:parent_id)
        parents = Relative.find(array_of_parent_ids)
        return parents
    end
    # => ^^ find_grandparent would be superfluous

    def find_sibling_relatives # including half
        siblings = []
        parents = self.find_parent_relatives
        parents.each do |parent|
            siblings += parent.find_child_relatives
        end
        siblings.uniq!   # => remove duplicates
        siblings.delete(self)  # => remove self, not his/her own sibling
        return siblings
    end

    def find_aunt_uncle_relatives
        aunts_uncles_all = []  # => includes spouses
        aunts_uncles_direct = []    # => doesn't include spouses
        parents = self.find_parent_relatives
        parents.each do |parent|
            aunts_uncles_direct += parent.find_sibling_relatives
        end
        aunts_uncles_direct.each do |a_or_u|
            aunts_uncles_all += [a_or_u]
            aunts_uncles_all += a_or_u.find_spouse_relatives
        end
        aunts_uncles_all.uniq!    # => just in case
        return aunts_uncles_all
    end

    # nieces & nephews
    def find_nibling_relatives
        niblings = []
        siblings = self.find_sibling_relatives
        siblings += self.find_sibling_IL_relatives
        siblings.each do |sibling|
            niblings += sibling.find_child_relatives
        end
        return niblings
    end

    def find_cousin_relatives
        cousins = []
        aunts_uncles = self.find_aunt_uncle_relatives
        aunts_uncles.each do |a_or_u|
            cousins += a_or_u.find_child_relatives
        end
        cousins.uniq!
        return cousins
    end

    def find_parent_IL_relatives  # => does not include ex parent_ILs
        parent_ILs = []
        current_spouse  = self.find_current_spouse_relative
        if current_spouse
            parent_ILs += current_spouse.find_parent_relatives
        end
        return parent_ILs
    end

    # => for joe and janey
    def find_grandparent_IL_relatives
        grandparent_ILs = []
        parent_ILs = self.find_parent_IL_relatives
        parent_ILs.each do |parent_IL|
            grandparent_ILs += parent_IL.find_parent_relatives
        end
        return grandparent_ILs
    end

    # => sibling ILs are (1) sibling's spouses, (2) spouse's siblings, (3) spouse's siblings spouses
    def find_sibling_IL_relatives # => does not include ex sibling_ILs, but does include step sibling ILs
        sibling_ILs = []
        siblings = self.find_sibling_relatives
        siblings += self.find_step_sibling_relatives

        current_spouse = self.find_current_spouse_relative
        if current_spouse
            sibling_ILs += current_spouse.find_sibling_relatives
            sibling_ILs += current_spouse.find_step_sibling_relatives

            siblings = current_spouse.find_sibling_relatives
            siblings += current_spouse.find_step_sibling_relatives

        end

        siblings.each do |sibling|
            if sibling.find_current_spouse_relative
                sibling_ILs += [sibling.find_current_spouse_relative]
            end
        end
        sibling_ILs.uniq!
        return sibling_ILs
    end

    def find_child_relatives
        array_of_child_ids = self.descendant_branches.pluck(:child_id)
        children = Relative.find(array_of_child_ids)
        return children
    end
    # => ^^ find_grandchild would be superfluous

    def find_step_child_relatives
        step_children = []
        spouse_children  =[]
        spouses = self.find_spouse_relatives
        spouses.each do |spouse|
            spouse_children += spouse.find_child_relatives
        end
        spouse_children.each do |spouse_child|
            child_step_parents = spouse_child.find_step_parent_relatives
            if child_step_parents.include?(self)
                step_children += [spouse_child]
            end
        end
        return step_children
    end

    def find_child_IL_relatives # => does not include ex child_ILs
        child_ILs = []
        children = self.find_child_relatives
        children.each do |child|
            if child.find_current_spouse_relative
                child_ILs += [child.find_current_spouse_relative]
            end
        end
        return child_ILs
    end

    # => for joe and janey
    def find_grandchild_IL_relatives # => does not include ex grandchildren_ILs
        grandchildren_ILs = []
        children = self.find_child_relatives
        children.each do |child|
            grandchildren = child.find_child_relatives
            grandchildren.each do |grandchild|
                if grandchild.find_current_spouse_relative
                    grandchildren_ILs += [grandchild.find_current_spouse_relative]
                end
            end
        end
        return grandchildren_ILs
    end

    def find_spouse_relatives #including ex-spouses
        array_of_spouse_ids = self.reverse_marriage_branches.pluck(:wife_id) + self.marriage_branches.pluck(:husband_id)
        spouses = Relative.find(array_of_spouse_ids)
        return spouses
    end

    # => this makes finding ex-spouses easier (although what about spouses that died?)
    def find_current_spouse_relative #darn jeff and all of his women
        current_spouse = nil

        current_marriage_array = self.reverse_marriage_branches.where(:marriage_end => nil) + self.marriage_branches.where(:marriage_end => nil)
        # => ^^size should be <=1
        if current_marriage_array
            current_marriage_ids = current_marriage_array.pluck(:husband_id, :wife_id).flatten
            # => ^^size should be <=2
            current_marriage_ids.delete(self.id)
            # => ^^ size should be <=1
            if current_marriage_ids.count > 0
                current_spouse = Relative.find(current_marriage_ids[0])
            end
        end
        return current_spouse
    end

    def find_step_parent_relatives
        parents = self.find_parent_relatives
        parent_marriages = []
        delete_marriages = []
        parents.each do |parent|    # => should only be two
            parent_marriages += (parent.reverse_marriage_branches + parent.marriage_branches)
            delete_marriages += (parent.reverse_marriage_branches.where("marriage_end < ? ", self.birthday) + parent.marriage_branches.where("marriage_end < ?", self.birthday))
        end
        parent_marriages.uniq!
        delete_marriages.uniq!
        parent_marriages.delete_if {|marriage| delete_marriages.include?(marriage) }
        # => now parent_marriages holds all marriages AFTER birth

        parent_ids = parents.pluck(:id)
        step_parent_ids = parent_marriages.pluck(:husband_id, :wife_id).flatten.uniq # => flat array of all parents (including actual parents)

        step_parent_ids.delete_if {|step_parent_id| parent_ids.include?(step_parent_id) } # => remove actual parents

        step_parents = Relative.find(step_parent_ids);

        return step_parents
    end

    def find_step_sibling_relatives
        step_siblings = []
        step_parents = self.find_step_parent_relatives
        step_parents.each do |step_parent|
            step_siblings += step_parent.find_child_relatives
        end
        return step_siblings
    end

    # => These next two methods are used for filtering relatives for marriage and descendant branches
    # => They will not be fun


    # => this will leave some holes with great aunts and uncles and great niblings,
    # => but lets hope age differences help a lot of that out
    def find_viable_spouse_relatives

        viable_spouses = Relative.all
        # => filter by sex first
        viable_spouses = viable_spouses.where.not(:sex => self.sex)

        # => only marry someone who was alive when self is/was alive

        # => those who died before self.birth
        too_dead = viable_spouses.where("deathday <= (?)",self.birthday)

        viable_spouses = too_dead.count>0 ? viable_spouses.where("id NOT IN (?)", too_dead.pluck(:id)) : viable_spouses

        # => those who were born after self.death
        if self.deathday
            too_alive = viable_spouses.where("birthday >= (?)", self.deathday)
            viable_spouses = too_alive.count>0 ? viable_spouses.where("id NOT IN (?)", too_alive.pluck(:id)): viable_spouses
        end

        # => now to remove all of the relatives

        # => parents and grandparents && great* aunts/uncles
        parents = self.find_parent_relatives
        grandparents = parents # => base
        while true
            #takes care of parent case as well
            viable_spouses = grandparents.count > 0 ? viable_spouses.where("id NOT IN (?)", grandparents.pluck(:id)) : viable_spouses

            # => also remove all (grand) parent siblings (aunts and uncles)
            aunts_uncles = []
            grandparents.each do |parent|
                aunts_uncles += parent.find_sibling_relatives
            end
            viable_spouses = aunts_uncles.count > 0 ? viable_spouses.where("id NOT IN (?)", aunts_uncles.pluck(:id)) : viable_spouses

            # => build up next level of grandparents
            new_grandparents = []
            grandparents.each do |parent|
                new_grandparents += parent.find_parent_relatives
            end
            # => if there are no grandparents at this level, quit adding grandparents
            # => Note: this is the only way to quit this loop
            if new_grandparents.count == 0
                break
            end
            grandparents = new_grandparents
        end

        # => children and grandchildren
        children = self.find_child_relatives
        grandchildren = children # => base
        while true
            #takes care of children case as well
            viable_spouses = grandchildren.count > 0 ? viable_spouses.where("id NOT IN (?)", grandchildren.pluck(:id)) : viable_spouses

            # => build up next level of grandchildren
            new_grandchildren= []
            grandchildren.each do |child|
                new_grandchildren += child.find_child_relatives
            end
            # => if there are no grandparents at this level, quit adding grandparents
            # => Note: this is the only way to quit this loop
            if new_grandchildren.count == 0
                break
            end
            grandchildren = new_grandchildren
        end

        # => siblings, niblings (one level)
        siblings = self.find_sibling_relatives
        viable_spouses = siblings.count>0 ? viable_spouses.where("id NOT IN (?)", siblings.pluck(:id)) : viable_spouses

        niblings = self.find_nibling_relatives
        viable_spouses = niblings.count > 0 ? viable_spouses.where("id NOT IN (?)", niblings.pluck(:id)) : viable_spouses

        # => hell, remove great niblings too (ex rosamund can't marry george, but could probably marry george's kid)
        # => anything else i hope will fall into the too_alive/too_dead category
        great_niblings = []
        niblings.each do |nibling|
            great_niblings += nibling.find_child_relatives
        end
        viable_spouses = great_niblings.count > 0 ? viable_spouses.where("id NOT IN (?)", great_niblings.pluck(:id)) : viable_spouses

        return viable_spouses
    end

    def find_viable_parent_relatives(parent_type) # => parent_type to determine sex (mom or dad?)
        viable_parents = Relative.all

        # => filter correct sex
        viable_parents = viable_parents.where(:sex => (parent_type =='mother')? "female": "male")

        # => filter those born after self
        viable_parents = viable_parents.where("birthday < (?)", self.birthday)

        # => filter out those who died more than 10 months before birth
        date_ten_months_before = Date.new(self.birthday.year, self.birthday.month-10, self.birthday.day)
        too_dead = viable_parents.where("deathday >= (?)", date_ten_months_before)
        viable_parents = too_dead.count > 0 ? viable_parents.where("id NOT IN (?)", too_dead.pluck(:id)) : viable_parents

        # => now to remove all of the relatives

        # => remove siblings
        siblings = self.find_sibling_relatives
        viable_parents = siblings.count > 0 ? viable_parents.where("id NOT IN (?)", siblings.pluck(:id)) : viable_parents

        # => parents and grandparents && great* aunts/uncles
        parents = self.find_parent_relatives
        grandparents = parents # => base
        while true
            #takes care of parent case as well
            #should keep current parents
            viable_parents = grandparents.count > 0 ? viable_parents.where("id NOT IN (?)", grandparents.pluck(:id)) : viable_parents

            # => also remove all (grand) parent siblings (aunts and uncles)
            aunts_uncles = []
            grandparents.each do |parent|
                aunts_uncles += parent.find_sibling_relatives
            end
            viable_parents = aunts_uncles.count > 0 ? viable_parents.where("id NOT IN (?)", aunts_uncles.pluck(:id)) : viable_parents

            # => build up next level of grandparents
            new_grandparents = []
            grandparents.each do |parent|
                new_grandparents += parent.find_parent_relatives
            end
            # => if there are no grandparents at this level, quit adding grandparents
            # => Note: this is the only way to quit this loop
            if new_grandparents.count == 0
                break
            end
            grandparents = new_grandparents
        end

        #remove spouses
        spouses = self.find_spouse_relatives
        viable_parents = spouses.count > 0 ? viable_parents.where("id NOT IN (?)", spouses.pluck(:id)) : viable_parents

        return viable_parents
    end
end
