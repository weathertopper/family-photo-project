class PhotoTag < ApplicationRecord
    belongs_to :relative
    belongs_to :photo

    validate :no_duplicate_photo_tags

    def no_duplicate_photo_tags
        already_exists = PhotoTag.where(:photo_id => photo_id).where(:relative_id => relative_id)
        if already_exists.count > 0
            errors.add(:relative_id, "Don't tag a relative in this photo twice!")
        end
    end
end
