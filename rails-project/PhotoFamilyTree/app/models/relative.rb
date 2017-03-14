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
end
