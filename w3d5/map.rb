class Map
    def initialize
        @map = []
    end

    def set(key, value)
        if @map.flatten.include?(key)
            @map.each do |i|
                i[1] = value if i[0]==key
            end
        else
            @map << [key, value]
        end
    end

    def get(key)
        return nil unless @map.include?(key)
        @map.each do |i|
            return i[1] if i[0]==key
        end
    end

    def delete(key)
        if @map.flatten.include?(key)
            @map.each_with_index do |i, idx|
                @map.delete_at(idx) if i[0]==key
            end
        end
    end

    def show
        @map
    end


end

my_map = Map.new

my_map.set("k"," v")
my_map.set("k", "p")
my_map.set("g", "k")
my_map.delete("g")
p my_map.show

