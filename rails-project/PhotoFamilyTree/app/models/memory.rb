class Memory < ApplicationRecord
    mount_uploader :audio_content, AudioUploader
end
