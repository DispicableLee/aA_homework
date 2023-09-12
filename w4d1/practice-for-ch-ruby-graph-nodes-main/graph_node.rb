class GraphNode

    attr_reader :value, :neighbors
    def initialize(value)
        @value = value
        @neighbors = []
    end

    def neighbors=(neighbors)
        @neighbors+=neighbors
    end

    def depth_first(node, visited = Set.new())
        return nil if (visited.include?(node.val))

        visited.add(node.val)

        node.neighbors.each do |neighbor|
            depth_first(neighbor, visited);
        end
    end



    def bfs(starting_node, target)
        queue = [starting_node]
        visited = []

        until queue.empty?

            current_node = queue.shift
            
            visited << current_node

            return current_node if current_node.val == target

            current_node.neighbors.each do |node|
                unless visited.include?(node)
                    queue << node
                end

            end
        end
        nil
    end

    
end

a = GraphNode.new('a')
b = GraphNode.new('b')
c = GraphNode.new('c')
d = GraphNode.new('d')
e = GraphNode.new('e')
f = GraphNode.new('f')
a.neighbors = [b, c, e]
c.neighbors = [b, d]
e.neighbors = [a]
f.neighbors = [e]

p a.bfs(a, "b")