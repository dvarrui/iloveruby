class TreeNode
  def initialize(name, parent)
    @name = name
    @parent = parent
    @children = []
  end

  def add_child(child)
    @children.push(child)
  end

  def name
    @name
  end

  def parent
    @parent
  end

  def <=>(other)
    name <=> other.name
  end

  def children
    @children.sort
  end
end

class Tree
  def initialize
    root = "root"
    nodes = {}
    nodes[root] = TreeNode.new(root, nil)
    nodes["Concept_1"] = TreeNode.new("Concept_1", root)
    nodes["Concept_2"] = TreeNode.new("Concept_2", root)
    nodes["Concept_3"] = TreeNode.new("Concept_3", root)

    nodes.each_value do |value|
      parent = nodes[value.parent]
      parent.add_child(value) if parent
    end

    @root = nodes[root]
  end

  def root
    @root
  end
end

class Data
  def self.get_methods(name)
    [ :a, :b, :c, name]
  end

  def self.get_constants(name)
    [1, 2, 3, 4, name].shuffle
  end
end
