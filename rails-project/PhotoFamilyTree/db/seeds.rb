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

    harold = Relative.create!({ :first => "Harold",
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
                                :deathday => Date.new(1920, 5, 25),
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
                            :end => Date.new(1920, 5, 25)})

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
        marriage = Event.create!({
                            :when => mbranch.anniversary,
                            :content => "#{husband.first} & #{wife.first} #{husband.surname} are married",
                            :event_type => "marriage_start",
                            :event_owner_id => mbranch.id})
        EventTag.create!({  :event_id => marriage.id,
                            :relative_id => husband.id})
        EventTag.create!({  :event_id => marriage.id,
                            :relative_id => wife.id})
        if mbranch.end
            marriage_end = Event.create!({
                                :when => mbranch.end,
                                :content => "#End of marriage between {husband.first} & #{wife.first} #{husband.surname}",
                                :event_type => "marriage_end",
                                :event_owner_id => mbranch.id})
            EventTag.create!({  :event_id => marriage_end.id,
                                :relative_id => husband.id})
            EventTag.create!({  :event_id => marriage_end.id,
                                :relative_id => wife.id})
        end

    end

    #Births, relevant to person being born and parents


    # => births and deaths
    Relative.all.each do |r|
        r.create_birth_event_and_tags
        r.create_death_event_and_tags
    end

    # => Events from timeline

    matthew_and_isobel_to_downton = Event.create!({
                        :when => Date.new(1912, 8, 15),
                        :content => "Matthew and Isobel move to Downton"})

    EventTag.create!({  :event_id => matthew_and_isobel_to_downton.id,
                        :relative_id => matthew.id})
    EventTag.create!({  :event_id => matthew_and_isobel_to_downton.id,
                        :relative_id => isobel.id})

    mary_porks_pamuk = Event.create!({
                        :when => Date.new(1913, 1, 15),
                        :content => "Mary porks a Turkish gent to death"})
    EventTag.create!({  :event_id => mary_porks_pamuk.id,
                        :relative_id => mary.id})

    sybil_presented = Event.create!({
                        :when => Date.new(1914, 6, 15),
                        :content => "Sybil is presented"})
    EventTag.create!({  :event_id => sybil_presented.id,
                        :relative_id => sybil.id})

    martha_hops_pond = Event.create!({
                        :when => Date.new(1920, 4, 15),
                        :content => "Martha comes to Downton for Matthew and Mary's wedding"})
    EventTag.create!({  :event_id => martha_hops_pond.id,
                        :relative_id => martha.id})

    edith_gets_pooched = Event.create!({
                        :when => Date.new(1920, 5, 15),
                        :content => "Edith gets jilted by Strallan"})
    EventTag.create!({  :event_id => edith_gets_pooched.id,
                        :relative_id => edith.id})

    robert_hops_pond = Event.create!({
                        :when => Date.new(1922, 7, 15),
                        :content => "Robert goes to America to help Harold"})
    EventTag.create!({  :event_id => robert_hops_pond.id,
                        :relative_id => robert.id})
    EventTag.create!({  :event_id => robert_hops_pond.id,
                        :relative_id => harold.id})

    harold_and_martha_hop_pond = Event.create!({
                        :when => Date.new(1923, 5, 15),
                        :content => "Harold and Martha visit Downton"})
    EventTag.create!({  :event_id => harold_and_martha_hop_pond.id,
                        :relative_id => harold.id})
    EventTag.create!({  :event_id => harold_and_martha_hop_pond.id,
                        :relative_id => martha.id})

    tom_and_sybbie_leave = Event.create!({
                        :when => Date.new(1925, 1, 15),
                        :content => "Tom and Sybbie leave Downton for Boston"})
    EventTag.create!({  :event_id => tom_and_sybbie_leave.id,
                        :relative_id => tom.id})
    EventTag.create!({  :event_id => tom_and_sybbie_leave.id,
                        :relative_id => sybbie.id})

    tom_and_sybbie_return = Event.create!({
                        :when => Date.new(1925, 5, 16),
                        :content => "Tom and Sybbie come back to Downton"})
    EventTag.create!({  :event_id => tom_and_sybbie_return.id,
                        :relative_id => tom.id})
    EventTag.create!({  :event_id => tom_and_sybbie_return.id,
                        :relative_id => sybbie.id})

    Memory.delete_all

    Relative.find_each do |r|
        15.times do |counter|
            Memory.create!({
                :poster_id => r.id,
                :title => "Memory of #{r.first} #{r.surname} #{counter}",
                :text_content =>
                        "Something something something something something something
                        something something something something something something
                        something something something something something something
                        something something something something something something
                        something something something something something something
                        something something something something something something
                        something something something something something something
                        something something something something something something
                        something something somethingsomething something something",
                        :location => "Downton Abbey"})
        end
    end
    # => special memory with audio
    Memory.create!({
                :poster_id => robert.id,
                :title => "Robert's Memory with audio",
                :text_content => "Robert and Cora talking about Marigold",
                :audio_content => File.open(File.join('/home/nathanweatherly/git/audio_for_seed/robert-about-marigold-to-cora.wav')),
        })

    Photo.delete_all
    PhotoTag.delete_all

    breakfast = Photo.create!({
            :taken_on => Date.new(1912),
            :header => "At breakfast",
            :caption => "Lord Grantham reading a telegraph on the morning the Titanic sank. Mary and Mr. Carson are also pictured.",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/at-breakfast.jpg')),
            :poster_id => edith.id,
            :location => "Downton Abbey breakfast hall"
    })
    PhotoTag.create!({
            :photo_id => breakfast.id,
            :relative_id => robert.id
    })
    PhotoTag.create!({
            :photo_id => breakfast.id,
            :relative_id => mary.id
    })

    tom_coming_home = Photo.create!({
            :taken_on => Date.new(1925),
            :header => "Tom coming home",
            :caption => "Tom and Sibbie talk to Mary after they return from Boston.",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/branson-coming-home.jpg')),
            :poster_id => edith.id,
            :location => "Downton Abbey"
    })
    PhotoTag.create!({
            :photo_id => tom_coming_home.id,
            :relative_id => mary.id
    })
    PhotoTag.create!({
            :photo_id => tom_coming_home.id,
            :relative_id => tom.id
    })
    PhotoTag.create!({
            :photo_id => tom_coming_home.id,
            :relative_id => sybbie.id
    })

    trenches = Photo.create!({
            :taken_on => Date.new(1915),
            :header => "Trenches",
            :caption => "Matthew in the trenches",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/in-the-trenches.jpg')),
            :poster_id => matthew.id,
            :location => "World War 1 Battlefield"
    })
    PhotoTag.create!({
            :photo_id => trenches.id,
            :relative_id => matthew.id
    })

    playing_cricket = Photo.create!({
            :taken_on => Date.new(1920),
            :header => "Cricket",
            :caption => "A group picture of cricket before Matthew died. Also pictured are Mr Carson, Alfred, Thomas, Mr Molesley, and other house staff. ",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/playing-cricket.jpg')),
            :poster_id => cora.id,
            :location => "World War 1 Battlefield"
    })
    PhotoTag.create!({
            :photo_id => playing_cricket.id,
            :relative_id => matthew.id
    })
    PhotoTag.create!({
            :photo_id => playing_cricket.id,
            :relative_id => robert.id
    })
    PhotoTag.create!({
            :photo_id => playing_cricket.id,
            :relative_id => tom.id
    })

    war_uniforms = Photo.create!({
            :taken_on => Date.new(1920),
            :header => "War Uniforms",
            :caption => "Family members involved in the war.",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/war-uniforms.jpg')),
            :poster_id => cora.id,
            :location => "Downton Abbey, during its time as an army hospital"
    })
    PhotoTag.create!({
            :photo_id => war_uniforms.id,
            :relative_id => matthew.id
    })
    PhotoTag.create!({
            :photo_id => war_uniforms.id,
            :relative_id => robert.id
    })
    PhotoTag.create!({
            :photo_id => war_uniforms.id,
            :relative_id => sybil.id
    })

    with_kids = Photo.create!({
            :taken_on => Date.new(1920),
            :header => "Children",
            :caption => "Parents and children (you know, the parents that aren't dead).",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/with-kids.jpg')),
            :poster_id => isobel.id,
            :location => "Downton Abbey"
    })
    PhotoTag.create!({
            :photo_id => with_kids.id,
            :relative_id => edith.id
    })
    PhotoTag.create!({
            :photo_id => with_kids.id,
            :relative_id => mary.id
    })
    PhotoTag.create!({
            :photo_id => with_kids.id,
            :relative_id => tom.id
    })
    PhotoTag.create!({
            :photo_id => with_kids.id,
            :relative_id => marigold.id
    })
    PhotoTag.create!({
            :photo_id => with_kids.id,
            :relative_id => george.id
    })
    PhotoTag.create!({
            :photo_id => with_kids.id,
            :relative_id => sybbie.id
    })

    concert = Photo.create!({
            :taken_on => Date.new(1914),
            :header => "Concert",
            :caption => "Charity concert during the Great War to raise money while the House acted as a hospital ",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/also-at-concert.jpg')),
            :poster_id => cora.id,
            :location => "Downton Abbey"
    })
    PhotoTag.create!({
            :photo_id => concert.id,
            :relative_id => violet.id
    })
    PhotoTag.create!({
            :photo_id => concert.id,
            :relative_id => cora.id
    })
    PhotoTag.create!({
            :photo_id => concert.id,
            :relative_id => robert.id
    })

    at_dinner = Photo.create!({
            :taken_on => Date.new(1912),
            :header => "Dinner",
            :caption => "An evening dinner (and Violet being her normal foxy self).",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/at-dinner.jpg')),
            :poster_id => edith.id,
            :location => "Downton Abbey"
    })
    PhotoTag.create!({
            :photo_id => at_dinner.id,
            :relative_id => violet.id
    })
    PhotoTag.create!({
            :photo_id => at_dinner.id,
            :relative_id => robert.id
    })

    hospital = Photo.create!({
            :taken_on => Date.new(1916),
            :header => "Hospital",
            :caption => "Matthew surprised Isobel at the hospital",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/hospital.jpg')),
            :poster_id => isobel.id,
            :location => "Downton Abbey (Hospital)"
    })
    PhotoTag.create!({
            :photo_id => hospital.id,
            :relative_id => matthew.id
    })
    PhotoTag.create!({
            :photo_id => hospital.id,
            :relative_id => isobel.id
    })

    out_shooting = Photo.create!({
            :taken_on => Date.new(1922),
            :header => "Out Shooting",
            :caption => "Tom, Mary, and Tony Foyle in the country",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/out-shooting.jpg')),
            :poster_id => violet.id,
            :location => "Countryside of Downton Abbey"
    })
    PhotoTag.create!({
            :photo_id => out_shooting.id,
            :relative_id => tom.id
    })
    PhotoTag.create!({
            :photo_id => out_shooting.id,
            :relative_id => mary.id
    })

    sisters = Photo.create!({
            :taken_on => Date.new(1912),
            :header => "Sisters",
            :caption => "How did they all get in the same picture?",
            :photograph => File.open(File.join('/home/nathanweatherly/git/images_for_seed/candid-photos/sisters.jpg')),
            :poster_id => violet.id,
            :location => "Downton Abbey"
    })
    PhotoTag.create!({
            :photo_id => sisters.id,
            :relative_id => edith.id
    })
    PhotoTag.create!({
            :photo_id => sisters.id,
            :relative_id => sybil.id
    })
    PhotoTag.create!({
            :photo_id => sisters.id,
            :relative_id => mary.id
    })
end
