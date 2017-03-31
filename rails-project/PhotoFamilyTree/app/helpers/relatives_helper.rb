module RelativesHelper

    def name_for_display(relative)
        if relative.nickname
            return "#{relative.nickname} #{relative.surname}"
        end
        return "#{relative.first} #{relative.surname}"
    end
end
