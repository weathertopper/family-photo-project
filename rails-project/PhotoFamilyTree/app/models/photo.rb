class Photo < ApplicationRecord

    #Validations
    validates :taken_on, presence: true
    validates :caption, presence: true
    validates :location, presence: true
    validates :photograph, presence: true
    validates :poster_id, presence: true

    #CarrierWave, :photograph is really an image, use the ImageUploader
    mount_uploader :photograph, ImageUploader

    #Connection to Relative for photographer id
    belongs_to :photographer, class_name: "Relative"

    #Connection to Relatives for photo tagging
    has_many :photo_tags
    has_many :relatives, :through => :photo_tags
end
