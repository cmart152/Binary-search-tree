require 'pry-byebug'

class Node
  include Comparable

  attr_accessor :data, :left_child, :right_child

  def initialize(data, left = nil, right = nil)
    @data = data
    @left_child = left
    @right_child = right
  end

end

class Tree

  def initialize(arr)
    @arr = arr.sort.uniq
    @root = build_tree(@arr)
  end

  def build_tree(arr = nil)
    if arr == nil
      return
    elsif arr.length > 1
      middle = arr.length / 2
        
      new_node = Node.new(arr[middle])

      left_arr = arr.slice(0..middle -1)
      right_arr = arr.slice(middle.. -1)
      new_node.left_child = build_tree(left_arr)
      new_node.right_child = build_tree(right_arr)
      puts new_node.data
    else
      return arr
    end
    new_node
  end

  def display_root
    puts @root.right_child.data
  end

end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

number_tree = Tree.new(arr)

number_tree.build_tree
number_tree.display_root



