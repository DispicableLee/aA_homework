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
        p self.value
        starting_node.neighbors.each do |n|
            n.bfs(n, target)
        end
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