class DescendantBranch < ApplicationRecord
    belongs_to :parent, :class_name => Relative
    belongs_to :child, :class_name => Relative

    validates :parent_type, presence: true
    validate :verify_foreign_keys_exist

    def verify_foreign_keys_exist
        if parent_id.blank?
            errors.add(:parent, " not selected!")
        end
        if child_id.blank?
            errors.add(:child, " not selected!")
        end
    end
end
