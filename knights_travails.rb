require "byebug"

class KnightPathFinder
  VALID_BOARD = (0..8).to_a
  POTENTIAL_MOVES = [[1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1]]

  def valid_pos(pos)
    y, x = pos
    return false unless VALID_BOARD.include?(x)
    return false unless VALID_BOARD.include?(y)
    return false if visited_positions.include?(pos)
    true
  end

  def valid_moves(pos)
    valid_moves = []

    y, x = pos
    POTENTIAL_MOVES.each do |checking_pos|
      y_add = checking_pos[0] + y
      x_add = checking_pos[1] + x
      if valid_pos([y_add, x_add])
        valid_moves << [y_add, x_add]
        @visited_positions << [y_add, x_add]
      end
    end

    valid_moves
  end

  attr_accessor :move_tree, :visited_positions, :possible_move_nodes, :root
  def initialize(pos)
    @visited_positions = [pos]
    @starting_position = pos
    @root = PolyTreeNode.new(@starting_position)
    @possible_move_nodes = [@root]
    build_move_tree
  end

  def find_path(target)
    queue = [root]
    return root if root.value == target
    until queue.empty?
      queue.each do |first|
        return trace_path_back(first) if first.value == target
        queue += first.children
        queue.shift
      end
    end

    nil
  end

def trace_path_back(node)
  path = []
  until node.parent == nil
    path << node.value
    node = node.parent
  end
  path << root.value
  return path.reverse
end


  def build_move_tree

    until possible_move_nodes.empty?
      current_node = possible_move_nodes.shift
      valid_moves(current_node.value).each do |move|
        new_node = PolyTreeNode.new(move)
        new_node.parent = current_node
        possible_move_nodes << new_node
      end
    end
  end


end



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
