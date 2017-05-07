class Memory < ApplicationRecord
    mount_uploader :audio_content, AudioUploader

    #Validations
    validates :title, presence: true
    validates :text_content, presence: true
    validates :location, presence: true
    validates :when, presence: true
end
