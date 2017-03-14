class Photo < ApplicationRecord

    #CarrierWave, :photograph is really an image, use the ImageUploader
    mount_uploader :photograph, ImageUploader

    #Connection to Relative for photographer id
    belongs_to :photographer, class_name: "Relative"

    #Connection to Relatives for photo tagging
    has_many :photo_tags
    has_many :relatives, :through => :photo_tags
end
