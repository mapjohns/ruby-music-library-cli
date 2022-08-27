module Concerns::Findable

    def find_by_name(name)
        found = []
        self.all.each do |song|
            found << song if song.name == name
        end
        return found[0]
    end

    def find_or_create_by_name(name)
        if self.find_by_name(name).nil?
            self.create(name)
        else
            return self.find_by_name(name)
        end
    end

end