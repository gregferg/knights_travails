require "byebug"

class PolyTreeNode

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

  def parent=(set_parent)
    if @parent == set_parent

    elsif @parent == nil
      if set_parent.nil?
        @parent = set_parent
      else
        @parent = set_parent
        set_parent.children << self
      end
    else
      if set_parent.nil?
        @parent = set_parent
      else
        @parent.children.delete(self)
        @parent = set_parent
        set_parent.children << self
      end

    end
  end


  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "Not a child!" unless children.include?(child)
    child.parent = nil
  end

  def children
    @children
  end

  def dfs(target_value)
    return self if self.value == target_value
    return nil if self.value != target_value && self.children.empty?

    next_dfs = nil
    children.each {|child| next_dfs ||= child.dfs(target_value)}

    next_dfs
  end

  def inspect
    @value.inspect
  end

  def bfs(target)
    queue = [self]
    return self if self.value == target
    until queue.empty?
      queue.each do |first|
        return first if first.value == target
        queue += first.children
        queue.shift
      end
    end

    nil
  end
end
