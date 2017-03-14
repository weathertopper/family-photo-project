class MarriageBranch < ApplicationRecord
    belongs_to :husband, :class_name => Relative
    belongs_to :wife, :class_name => Relative
end
