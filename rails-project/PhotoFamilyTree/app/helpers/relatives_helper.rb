require 'json'

module RelativesHelper

    def name_for_display(relative)
        if relative.nickname
            return "#{relative.nickname} #{relative.surname}"
        end
        return "#{relative.first} #{relative.surname}"
    end

    @@relation = 0

    def return_relation(relative)
        @@relation+=1;
        return "#{relative} >>#{@@relation}<<"
    end

    def build_tree_for_relative(selected)
        # => have references to models via controller (index)
        # => selected = @alls.find(relative_id)

        # => The goal is to build up a flat hash of every
        # => {relative_id => "string_relation"} to then pass
        # => to the view, which will use some div id magic to
        # => display the proper values

        # => helpers from model
        parents = selected.find_parent_relatives
        children = selected.find_child_relatives
        spouses = selected.find_spouse_relatives #including ex spouses
        siblings = selected.find_sibling_relatives
        step_parents = selected.find_step_parent_relatives #including ex step parents
        step_siblings = selected.find_step_sibling_relatives
        aunt_uncles = selected.find_aunt_uncle_relatives
        niblings = selected.find_nibling_relatives
        cousins = selected.find_cousin_relatives
        parentILs = selected.find_parent_IL_relatives
        grandparentILs = selected.find_grandparent_IL_relatives
        siblingILs = selected.find_sibling_IL_relatives
        childrenILs = selected.find_child_IL_relatives
        grandchildrenILs = selected.find_grandparent_IL_relatives

        # => add the rest of them here

        relations = {};

        # => add to hash by: relations[:id] => "RELATION"

        # => use these for later
        mother = nil
        father = nil

        # => PARENTS
        # => assume 2 (will make >2 impossible at some point)
        parents.each do |parent|
            relation_title = nil
            if parent.sex == 'male'
                father = parent
                relation_title = 'Father'
            else
                mother = parent
                relation_title = "Mother"
            end
            relations[parent.id] = relation_title
        end

        # => SIBLINGS (HALF AND FULL)


        siblings.each do |sibling|

            sibling_parents = sibling.find_parent_relatives

            sibling_father = nil
            sibling_mother = nil
            # => assume 2
            sibling_parents.each do |sibling_parent|
                if sibling_parent.sex == 'male'
                    sibling_father = sibling_parent
                else
                    sibling_mother = sibling_parent
                end
            end

            prefix = (sibling_father != father || sibling_mother != mother)? "Half " : ""
            sibling_sex = sibling.sex== 'male' ? "Brother": "Sister"
            relation_title = prefix + sibling_sex

            relations[sibling.id] = relation_title
        end

        # => STEP PARENTS
        step_parents = []

        if mother
            step_parents += mother.find_spouse_relatives
        end

        if father
            step_parents += father.find_spouse_relatives
        end

        step_parents = step_parents.uniq
        step_parents.delete(mother)
        step_parents.delete(father)

        # Will show all step parents, including ex step parents
        step_parents.each do |step_parent|
            relation_title = step_parent.sex == 'male'? "Step Father" : "Step Mother"
            relations[step_parent.id] = relation_title
        end

        # => STEP SIBLINGS
        step_siblings = []
        step_parents. each do |step_parent|
            step_siblings += step_parent.find_child_relatives
        end
        step_siblings = step_siblings.uniq   # => remove duplicates (how is this possible?)

        step_siblings.each do |step_sibling|
            relation_title = step_sibling.sex== 'male' ? "Step Brother": "Step Sister"
            relations[step_sibling.id] = relation_title
        end


        # => (GREAT*) GRANDPARENTS
        grandparents = parents # => base
        great_count = 0

        while true

            # => build up next level of grandparents
            new_grandparents = []

            grandparents.each do |parent|
                new_grandparents += parent.find_parent_relatives
            end

            # => if there are no grandparents at this level, quit adding grandparents
            # => Note: this is the only way to quit this loop
            if new_grandparents.count == 0
                break
            end

            new_grandparents.each do |grandparent|
                pa_or_ma = grandparent.sex == 'male' ? 'Grandfather' : 'Grandmother'
                prefix = great_count > 0 ? "Great " : ""
                if great_count > 1
                    prefix += "(X#{great_count}) "
                end
                relation_title = prefix + pa_or_ma
                relations[grandparent.id] = relation_title
            end

            # => now get ready for the next loop
            great_count += 1
            grandparents = new_grandparents

        end

        # => AUNTS/UNCLES

        # => COUSINS

        # => SPOUSE (AND EX SPOUSES)

        # => PARENT-IN-LAWS

        # => SIBLING-IN-LAWS


        return relations.to_json
        # return "WORKING"
    end
    #code directly from my other example
    #should build tree in model and pass it to here (so marriage branches aren't even mentioned)
    # tree is array of {relative, level} hashes
# def buildTree(root, relatives, offspring_branches, spouse_branches)
#     # 'root' is a predefined relative- assumed to be the first person ever added to the tree
#
#     #tree init
#     tree = [{"relative" => root, "level" => 0}]
#
#     tree.each do |knob|
#
#         relative = knob["relative"]
#         level = knob["level"]
#
#         #adding spouses
#         if (relative.sex == 'male') # there has to be a better way to do this
#             relative.spouse_branches.each do |spouse_branch|
#                 wife = Relative.find(spouse_branch.wife_id)
#                 unless treeIncludes(wife, tree )
#                     tree.insert(tree.length, {"relative" => wife, "level" => level})
#                 end
#             end
#         else
#             relative.spouse_branches.each do |spouse_branch|
#                 husband =  Relative.find(spouse_branch.husband_id)
#                 unless treeIncludes(husband, tree )
#                     tree.insert(tree.length, {"relative" => husband, "level" => level})
#                 end
#             end
#         end
#
#         #adding kids
#         relative.offspring_branches.each do |kid_branch|
#             kid = Relative.find(kid_branch.child_id)
#             unless treeIncludes(kid, tree )
#                 tree.insert(tree.length, {'relative' => kid, "level" => level+1})
#             end
#         end
#
#         #adding parents
#         relative.reverse_offspring_branches.each do |parent_branch|
#             parent = Relative.find(parent_branch.parent_id)
#             unless treeIncludes(parent, tree )
#                 tree.insert(tree.length, {'relative' => parent, "level" => level-1})
#             end
#         end
#
#     end
#
#     #sort smallest to largest (highest to lowest) level
#     tree.sort_by! { |knob| knob['level'] }
#
#     #normalize so 'highest' level is 0
#     smallest_level = tree[0]['level']
#     difference_to_0 = 0 - smallest_level
#     tree.each do |knob|
#         knob['level'] += difference_to_0
#     end
#
#     return tree
# end
#
# def treeIncludes(relative, tree)
#     tree.each do |knob|
#         if knob['relative'] == relative
#             return true
#         end
#     end
#     return false
# end
end
