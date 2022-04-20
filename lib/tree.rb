require_relative 'node'
require 'pry-byebug'

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
      new_node = Node.new(arr[0])
    end
    new_node
  end

  def find(value, current_node = @root)
    return current_node if current_node.nil? || current_node.data.equal?(value)
    
    if value < current_node.data
     find(value, current_node.left_child)
    else 
     find(value, current_node.right_child)
    end
  end

  def find_parent(value, current_node = @root, previous_node = nil)
    if value == current_node.data
      previous_node
    elsif value < current_node.data
      find_parent(value, current_node.left_child, current_node)
    else
      find_parent(value, current_node.right_child, current_node)
    end
  end

  def insert(value, current_node = @root, previous_node = nil)
    if current_node.data == nil
      current_node = Node.new(value)
    elsif current_node.data > value
      if current_node.left_child == nil
        current_node.left_child = Node.new(value)
      else
        insert(value, current_node.left_child)
      end
    else
      if current_node.right_child == nil
        current_node.right_child = Node.new(value)
      else
        insert(value, current_node.right_child, current_node)
      end
    end
  end

  def delete_leaf(value, current_node = @root, previous_node = nil)
    if value == current_node.data
      if previous_node.left_child != nil && previous_node.left_child.data == value
        previous_node.left_child.data = nil
        return
      else
        previous_node.right_child.data = nil
        return
      end
    end

    if value < current_node.data
      delete_leaf(value, current_node.left_child, current_node)
    elsif value > current_node.data
      delete_leaf(value, current_node.right_child, current_node)
    end
  end

  def delete(value)
    node = find(value)
    node_parent = find_parent(value)

    if node.right_child == nil && node.left_child == nil
      node.data = nil
    elsif node.right_child.data != nil && node.left_child.data == nil
      if node.data > node_parent.data
        node_parent.right_child = node.right_child
      else
        node_parent.left_child = node.right_child
      end
    elsif node.right_child.data == nil && node.left_child.data != nil
      if node.data > node_parent.data
        node_parent.right_child = node.left_child
      else
        node_parent.left_child = node.left_child
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end