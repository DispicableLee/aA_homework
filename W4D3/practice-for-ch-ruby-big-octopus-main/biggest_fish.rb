fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 
 'fiiiissshhhhhh']



def clever_octopus(arr)
    highest = arr.shift
    arr.each do |fish|
        highest = fish if highest.length<fish.length
    end
    highest
end


tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", 
"left",  "left-up"]


def fast_dance(direction, tiles)
    tiles.index(direction)
    nil
end