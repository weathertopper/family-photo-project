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
        spouses = selected.find_spouse_relatives #all ex spouses
        current_spouse = selected.find_current_spouse_relative
        siblings = selected.find_sibling_relatives
        step_parents = selected.find_step_parent_relatives #including ex step parents
        step_siblings = selected.find_step_sibling_relatives
        step_children = selected.find_step_child_relatives
        aunt_uncles = selected.find_aunt_uncle_relatives
        niblings = selected.find_nibling_relatives
        cousins = selected.find_cousin_relatives
        parent_ILs = selected.find_parent_IL_relatives
        grandparent_ILs = selected.find_grandparent_IL_relatives
        sibling_ILs = selected.find_sibling_IL_relatives
        children_ILs = selected.find_child_IL_relatives
        grandchildren_ILs = selected.find_grandparent_IL_relatives


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

        # => CHILDREN
        children.each do |child|
            relation_title = child.sex == 'male'? "Son" : "Daughter"
            relations[child.id] = relation_title
        end

        # => STEP PARENTS
        # Will show all step parents, including ex step parents (won't distinguish though)
        step_parents.each do |step_parent|
            relation_title = step_parent.sex == 'male'? "Step Father" : "Step Mother"
            relations[step_parent.id] = relation_title
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

        # => STEP SIBLINGS (no such thing as 'ex' step sibling)
        step_siblings.each do |step_sibling|
            relation_title = step_sibling.sex== 'male' ? "Step Brother": "Step Sister"
            relations[step_sibling.id] = relation_title
        end


        # => (GREAT*) GRANDPARENTS
        # => No step grandparents at this time
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

        # => (GREAT*) GRANDCHILDREN
        grandchildren = children # => base
        great_count = 0
        while true
            # => build up next level of grandchildren
            new_grandchildren = []

            grandchildren.each do |child|
                new_grandchildren += child.find_child_relatives
            end

            # => if there are no grandchildren at this level, quit adding grandparents
            # => Note: this is the only way to quit the loop
            if new_grandchildren.count == 0
                break
            end

            new_grandchildren.each do |grandchild|
                s_or_d = grandchild.sex == 'male' ? 'Grandson' : "Granddaughter"
                prefix = great_count > 0 ? "Great ": ""
                if great_count > 1
                    prefix += "(X#{great_count}) "
                end
                relation_title = prefix + s_or_d
                relations[grandchild.id] = relation_title
            end

            great_count += 1
            grandchildren = new_grandchildren
        end

        # => AUNTS/UNCLES
        # => No great aunts/uncles at this time.
        # => Should probably add them (hate to piss off Peggy)
        aunt_uncles.each do |a_or_u|
            relation_title = a_or_u.sex== 'male' ? "Uncle": "Aunt"
            relations[a_or_u.id] = relation_title
        end

        # => COUSINS
        cousins.each do |cousin|
            relation_title = "Cousin"
            relations[cousin.id] = relation_title
        end

        # => NIECES & NEPHEWS
        niblings.each do |nibling|
            relation_title = nibling.sex== 'male' ? "Nephew": "Niece"
            relations[nibling.id] = relation_title
        end

        # => SPOUSES (DEAD AND EX SPOUSES)
        spouses.each do |spouse|
            if spouse == current_spouse
                next
            end
            # => Did the marriage end or the spouse die?
            # => (Figure that out later)
            relation_title = spouse.sex == 'male' ? "Husband (previous)": "Wife (previous)"
            relations[spouse.id] = relation_title
        end

        # => CURRENT SPOUSE
        if current_spouse #could be nil
            relation_title = current_spouse.sex == 'male' ? "Husband": "Wife"
            relations[current_spouse.id] = relation_title
        end

        # => PARENT-IN-LAWS
        parent_ILs.each do |parent_IL|
            relation_title = parent_IL.sex == 'male' ? "Father-in-Law": "Mother-in-Law"
            relations[parent_IL.id] = relation_title
        end

        # => SIBLING-IN-LAWS
        sibling_ILs.each do |sibling_IL|
            relation_title = sibling_IL.sex == 'male' ? "Brother-in-Law": "Sister-in-Law"
            relations[sibling_IL.id] = relation_title
        end

        # => GRANDPARENT-IN-LAWS
        grandparent_ILs.each do |grandparent_IL|
            relation_title = grandparent_IL.sex == 'male' ? "Grandfather-in-Law": "Grandmother-in-Law"
            relations[grandparent_IL.id] = relation_title
        end

        # => GRANDCHILDREN-IN-LAWS
        grandchildren_ILs.each do |grandchildren_IL|
            relation_title = grandchildren_IL.sex == 'male' ? "Grandson-in-Law": "Granddaughter-in-Law"
            relations[grandchildren_IL.id] = relation_title
        end


        # => STEP CHILDREN
        step_children.each do |step_child|
            relation_title = step_child.sex == 'male' ? "Step Son": "Step Daughter"
            relations[step_child.id] = relation_title
        end


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
