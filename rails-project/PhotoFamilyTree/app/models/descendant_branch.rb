class DescendantBranch < ApplicationRecord
    belongs_to :parent, :class_name => Relative
    belongs_to :child, :class_name => Relative
end
