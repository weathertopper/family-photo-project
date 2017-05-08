class Photo < ApplicationRecord

    #Validations
    validates :taken_on, presence: true
    validates :caption, presence: true
    validates :location, presence: true
    validates :photograph, presence: true

    #CarrierWave, :photograph is really an image, use the ImageUploader
    mount_uploader :photograph, ImageUploader

    #Connection to Relative for photographer id
    belongs_to :photographer, class_name: "Relative"

    #Connection to Relatives for photo tagging
    has_many :photo_tags
    has_many :relatives, :through => :photo_tags

    def viable_relatives_to_tag
        relatives = Relative.all
        #remove relatives already tagged
        photo_tags = PhotoTag.where(:photo_id => self.id)
        relatives = photo_tags.count > 0 ? relatives.where("id NOT IN (?)", photo_tags.pluck(:relative_id)) : relatives
        #remove relatives not born yet
        relatives = relatives.where("birthday <= (?)", self.taken_on)
        #remove relatives too dead
        too_dead = relatives.where("deathday < (?)", self.taken_on)
        relatives = too_dead.count > 0 ? relatives.where("id NOT IN (?)", too_dead.pluck(:id)) : relatives
        return relatives
    end

end
