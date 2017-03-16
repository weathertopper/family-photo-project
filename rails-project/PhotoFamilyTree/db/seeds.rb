# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
    # I will use dev as a testing env and wipe out whatever I want. I will need to
    # be more careful closer to prod

    # => Welcome to Downton Abbey, home of the Crawley family.

    Relative.delete_all

    violet = Relative.create!({ :first => "Violet",
                                :middle => "middle-name-here",
                                :maiden => 'maiden-name-here',
                                :surname => 'Crawley',
                                :nickname => 'Granny',
                                :sex => "female",
                                :birthday => Date.new(1842, 12, 28),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/violet_crawley.jpg'))})

    isobel = Relative.create!({ :first => "Isobel",
                                :middle => "Crawley",
                                :maiden => 'Turnbull',
                                :surname => 'Grey',
                                :sex => "female",
                                :birthday => Date.new(1853, 6, 3),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/isobel_crawley.jpeg')) })

    martha = Relative.create!({ :first => "Martha",
                                :surname => 'Levinson',
                                :nickname => 'Grandmama',
                                :sex => "female",
                                :birthday => Date.new(1840, 4, 24),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/martha_levinson.jpg'))})

    robert = Relative.create!({ :first => "Robert",
                                :surname => 'Crawley',
                                :sex => "male",
                                :birthday => Date.new(1866, 11, 10),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/robert_crawley.jpg'))})

    cora = Relative.create!({   :first => "Cora",
                                :maiden => 'Levinson',
                                :surname => 'Crawley',
                                :sex => "female",
                                :birthday => Date.new(1868, 7, 18),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/cora_crawley.jpg'))})

    rosamund = Relative.create!({:first => "Rosamund",
                                :maiden => 'Crawley',
                                :surname => 'Painswick',
                                :sex => "female",
                                :birthday => Date.new(1860, 11, 27),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/rosamund_painswick.jpg'))})

    harold = Relative.create!({:first => "Harold",
                                :surname => 'Levinson',
                                :sex => "male",
                                :birthday => Date.new(1866, 6, 6),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/harold_levinson.png'))})

    mary = Relative.create!({   :first => "Mary",
                                :middle => "Josephine",
                                :maiden => "Crawley",
                                :surname => 'Talbot',
                                :sex => "female",
                                :birthday => Date.new(1891, 12, 15),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/mary_crawley.jpg'))})

    edith = Relative.create!({  :first => "Edith",
                                :maiden => 'Crawley',
                                :surname => 'Pelham',
                                :sex => "female",
                                :birthday => Date.new(1892, 7, 16),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/edith_crawley.jpg'))})

    sybil = Relative.create!({  :first => "Sybil",
                                :middle => "Cora",
                                :maiden => 'Crawley',
                                :surname => 'Branson',
                                :sex => "female",
                                :birthday => Date.new(1895, 9, 14),
                                :deathday => Date.new(1920, 5, 15),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/sybil_crawley.png'))})

    matthew = Relative.create!({:first => "Matthew",
                                :middle => "Reginald",
                                :surname => 'Crawley',
                                :sex => "male",
                                :birthday => Date.new(1885, 10, 10),
                                :deathday => Date.new(1921, 9, 15),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/matthew_crawley.jpg'))})

    tom = Relative.create!({    :first => "Tom",
                                :surname => 'Branson',
                                :sex => "male",
                                :birthday => Date.new(1884, 9, 15),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/tom_branson.jpg'))})

    henry = Relative.create!({  :first => "Henry",
                                :surname => 'Talbot',
                                :sex => "male",
                                :birthday => Date.new(1885, 4, 3),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/henry_talbot.jpg'))})

    bertie = Relative.create!({ :first => "Herbert",
                                :middle => "middle-name-here",
                                :maiden => 'maiden-name-here',
                                :surname => 'Pelham',
                                :nickname => 'Bertie',
                                :sex => "male",
                                :birthday => Date.new(1892, 4, 10),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/bertie_pelham.jpg'))})

    sybbie = Relative.create!({ :first => "Sybil",
                                :surname => 'Branson',
                                :nickname => 'Sybbie',
                                :sex => "female",
                                :birthday => Date.new(1920, 5, 25),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/sybbie_branson.jpg'))})

    george = Relative.create!({ :first => "George",
                                :surname => 'Crawley',
                                :nickname => 'Georgie',
                                :sex => "male",
                                :birthday => Date.new(1921, 9, 30),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/george_crawley.jpg'))})

    marigold = Relative.create!({:first => "Marigold",
                                :surname => 'Gregson',
                                :sex => "female",
                                :birthday => Date.new(1923, 1, 3),
                                :profile_photo => File.open(File.join('/home/nathanweatherly/git/images_for_seed/marigold_gregson.png'))})


    # => Births in chronological order

    DescendantBranch.delete_all

    DescendantBranch.create!({:parent_id => violet.id, :child_id => robert.id})
    DescendantBranch.create!({:parent_id => violet.id, :child_id => rosamund.id})
    DescendantBranch.create!({:parent_id => martha.id, :child_id => harold.id})
    DescendantBranch.create!({:parent_id => martha.id, :child_id => cora.id})
    DescendantBranch.create!({:parent_id => isobel.id, :child_id => matthew.id})
    DescendantBranch.create!({:parent_id => cora.id, :child_id => mary.id})
    DescendantBranch.create!({:parent_id => robert.id, :child_id => mary.id})
    DescendantBranch.create!({:parent_id => cora.id, :child_id => edith.id})
    DescendantBranch.create!({:parent_id => robert.id, :child_id => edith.id})
    DescendantBranch.create!({:parent_id => cora.id, :child_id => sybil.id})
    DescendantBranch.create!({:parent_id => robert.id, :child_id => sybil.id})
    DescendantBranch.create!({:parent_id => sybil.id, :child_id => sybbie.id})
    DescendantBranch.create!({:parent_id => tom.id, :child_id => sybbie.id})
    DescendantBranch.create!({:parent_id => mary.id, :child_id => george.id})
    DescendantBranch.create!({:parent_id => matthew.id, :child_id => george.id})
    DescendantBranch.create!({:parent_id => edith.id, :child_id => marigold.id})

    # => Marriages in chronological order

    MarriageBranch.delete_all

    MarriageBranch.create!({:wife_id => cora.id,
                            :husband_id => robert.id,
                            :anniversary => Date.new(1890, 2, 16)})

    MarriageBranch.create!({:wife_id => sybil.id,
                            :husband_id => tom.id,
                            :anniversary => Date.new(1919, 4, 16),
                            :end => Date.new(1920, 5, 17)})

    MarriageBranch.create!({:wife_id => mary.id,
                            :husband_id => matthew.id,
                            :anniversary => Date.new(1920, 3, 13),
                            :end => Date.new(1921, 9, 15)})

    MarriageBranch.create!({:wife_id => mary.id,
                            :husband_id => henry.id,
                            :anniversary => Date.new(1925, 7, 25)})

    MarriageBranch.create!({:wife_id => edith.id,
                            :husband_id => bertie.id,
                            :anniversary => Date.new(1925, 12, 31)})

    Event.delete_all
    EventTag.delete_all

    #Marriages, relevant to the two getting married
    MarriageBranch.find_each do |mbranch|
        wife = Relative.find(mbranch.wife_id);
        husband = Relative.find(mbranch.husband_id)
        marriage = Event.create!({  :when => mbranch.anniversary,
                                    :content => "#{husband.first} & #{wife.first} #{husband.surname} are married"})
        EventTag.create!({  :event_id => marriage.id,
                            :relative_id => husband.id})
        EventTag.create!({  :event_id => marriage.id,
                            :relative_id => wife.id})
    end

    #Births, relevant to person being born and parents

    Relative.find_each do |r|
        event_content = ""
        parents = r.reverse_descendant_branches
        if parents.count() == 1
            parent_one = Relative.find(parents[0].parent_id) #returns relative object
            event_content =  "Birth of #{r.first} to #{parent_one.first}"
        elsif parents.count() ==2
            parent_one = Relative.find(parents[0].parent_id) #returns relative object
            parent_two = Relative.find(parents[1].parent_id) #returns relative object
            event_content =  "Birth of #{r.first} to #{parent_one.first} and #{parent_two.first}"
        else
            event_content = "Birth of #{r.first}"
        end
        birth = Event.create!({:when => r.birthday,
                                :content => event_content})
        EventTag.create!({:event_id => birth.id,
                            :relative_id => r.id})
        parents.find_each do |p|
            EventTag.create!({:event_id => birth.id,
                                :relative_id => p.id})
        end
    end

    #Deaths, relevant to person, spouse, and children
    Relative.find_each do |r|
        if r.deathday
            death = Event.create!({:when => r.deathday,
                                    :content => "Death of #{r.first}"})
            EventTag.create!({:event_id => death.id,
                            :relative_id => r.id})

            children = r.descendant_branches
            children.find_each do |c|
                child = Relative.find(c.child_id)
                if !child.deathday || (child.deathday && r.deathday < child.deathday)
                    EventTag.create!({:event_id => death.id,
                                        :relative_id => child.id})
                end
            end

            parents = r.reverse_descendant_branches
            parents.find_each do |p|
                parent = Relative.find(p.parent_id)
                if !parent.deathday || (parent.deathday && r.deathday < parent.deathday)
                    EventTag.create!({:event_id => death.id,
                                        :relative_id => parent.id})
                end
            end

            # => DO SPOUSES HERE!!!
            # => Note, marriages are owned by the wife.
            marriages = "" #branches
            if r.sex == "male"
                marriages = r.reverse_marriage_branches
            else
                marriages = r.marriage_branches
            end

            marriages.find_each do |m|
                spouse = (r.sex == "male")? Relative.find(m.wife_id) : Relative.find(m.husband_id)
                if !spouse.deathday || (spouse.deathday && r.deathday < spouse.deathday)
                    EventTag.create!({:event_id => death.id,
                                        :relative_id => spouse.id})
                end
            end

        end
    end

    # => Events from timeline

    matthew_and_isobel_to_downton = Event.create!({
                                        :when => Date.new(1912, 8, 15),
                                        :content => "Matthew and Isobel move to Downton"})

    EventTag.create!({ :event_id => matthew_and_isobel_to_downton.id,
                        :relative_id => matthew.id})
    EventTag.create!({ :event_id => matthew_and_isobel_to_downton.id,
                        :relative_id => isobel.id})

    mary_porks_pamuk = Event.create!({
                                :when => Date.new(1913, 1, 15),
                                :content => "Mary porks a Turkish gent to death"})
    EventTag.create!({   :event_id => mary_porks_pamuk.id,
                        :relative_id => mary.id})

    sybil_presented = Event.create!({
                        :when => Date.new(1914, 6, 15),
                        :content => "Sybil is presented"})
    EventTag.create!({:event_id => sybil_presented.id,
                        :relative_id => sybil.id})

    martha_hops_pond = Event.create!({
                        :when => Date.new(1920, 4, 15),
                        :content => "Martha comes to Downton for Matthew and Mary's wedding"})
    EventTag.create!({:event_id => martha_hops_pond.id,
                        :relative_id => martha.id})

    edith_gets_pooched = Event.create!({
                        :when => Date.new(1920, 5, 15),
                        :content => "Edith gets jilted by Strallan"})
    EventTag.create!({:event_id => edith_gets_pooched.id,
                        :relative_id => edith.id})

    robert_hops_pond = Event.create!({
                        :when => Date.new(1922, 7, 15),
                        :content => "Robert goes to America to help Harold"})
    EventTag.create!({:event_id => robert_hops_pond.id,
                        :relative_id => robert.id})
    EventTag.create!({:event_id => robert_hops_pond.id,
                        :relative_id => harold.id})

    harold_and_martha_hop_pond = Event.create!({
                        :when => Date.new(1923, 5, 15),
                        :content => "Harold and Martha visit Downton"})
    EventTag.create!({:event_id => harold_and_martha_hop_pond.id,
                        :relative_id => harold.id})
    EventTag.create!({:event_id => harold_and_martha_hop_pond.id,
                        :relative_id => martha.id})

    tom_and_sybbie_leave = Event.create!({
                            :when => Date.new(1925, 1, 15),
                            :content => "Tom and Sybbie leave Downton for Boston"})
    EventTag.create!({:event_id => tom_and_sybbie_leave.id,
                        :relative_id => tom.id})
    EventTag.create!({:event_id => tom_and_sybbie_leave.id,
                        :relative_id => sybbie.id})

    tom_and_sybbie_return = Event.create!({
                            :when => Date.new(1925, 5, 16),
                            :content => "Tom and Sybbie come back to Downton"})
    EventTag.create!({:event_id => tom_and_sybbie_return.id,
                    :relative_id => tom.id})
    EventTag.create!({:event_id => tom_and_sybbie_return.id,
                    :relative_id => sybbie.id})

    Memory.delete_all

    Memory.create!({ :poster_id => robert.id,
                        :title => "Robert's Memory" ,
                        :text_content =>
                        "Something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something
                        something something something",
                        :location => "Downton Abbey"})

    Memory.create!({ :poster_id => matthew.id,
                      :title => "Matthew's Memory" ,
                      :text_content =>
                      "Something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something
                      something something something",
                      :location => "In the trenches"})



end
