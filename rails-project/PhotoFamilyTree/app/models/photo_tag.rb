class PhotoTag < ApplicationRecord
    belongs_to :relative
    belongs_to :photo
end
