class TreeNode

attr_reader :value, :parent

  # def self.create_node(value)
  #   child_node = TreeNode.new(value)
  #   child_node.parent = self
  #   self.children << child_node
  # end

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    @parent = parent
    parent.children << self
  end


  def children
    @children
  end


end
