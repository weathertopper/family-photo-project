class Memory < ApplicationRecord

    #Connection to Relatives for memory tagging
    has_many :memory_tags
    has_many :relatives, :through => :memory_tags
end
