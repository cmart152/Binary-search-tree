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
      new_node.left_child = build_tree(arr.slice(0..middle -1))
      new_node.right_child = build_tree(arr.slice(middle + 1.. -1))
    else
      new_node = Node.new(arr)
    end
    new_node
  end

  def display_root
    puts @root.right_child.data
  end

  def find(control, current_node = @root)
    return current_node if current_node.nil? || current_node.data.equal?(control)
    
    if control < current_node.data
     find(control, current_node.left_child)
    else 
     find(control, current_node.right_child)
    end
  end

  def insert(value, current_node = @root)
  

  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

number_tree = Tree.new(arr)
number_tree.pretty_print 
puts number_tree.find(6345)