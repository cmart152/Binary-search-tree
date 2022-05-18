require_relative 'node'
require 'pry-byebug'

class Tree
  def initialize(arr)
    @arr = arr.sort.uniq
    @root = build_tree(@arr)
  end

  def build_tree(arr = nil)
    if  arr[0] == nil
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

  def delete(value)
    node = find(value)
    node_parent = find_parent(value)

    if node.right_child == nil && node.left_child == nil
      delete_leaf(node, node_parent)
    elsif node.left_child != nil && node.right_child != nil
      delete_node_two_child(node, node_parent)
    else
      delete_node_one_child(node, node_parent)
    end
  end

  def delete_leaf(node, node_parent)
    if node.data > node_parent.data
      node_parent.right_child = nil
    else
      node_parent.left_child = nil
    end
  end

  def delete_node_one_child(node, node_parent)
    if node.right_child != nil && node.left_child == nil
      if node.data > node_parent.data
        node_parent.right_child = node.right_child
      else
        node_parent.left_child = node.right_child
      end
    elsif node.right_child == nil && node.left_child != nil
      if node.data > node_parent.data
        node_parent.right_child = node.left_child
      else
        node_parent.left_child = node.left_child
      end
    end
  end

  def delete_node_two_child(node, node_parent)
    successor = find_successor(node.right_child)
    successor_parent = find_parent(successor.data)
    successor_parent.left_child = nil
    successor.left_child = node.left_child
    successor.right_child = node.right_child
    if node.data > node_parent.data
      node_parent.right_child = successor
    else
      node_parent.left_child = successor
    end
  end

  def find_successor(node)
    if node.left_child == nil
      return node
    else
      find_successor(node.left_child)
    end
  end

  def level_order(level_arr = [@root], keep_arr = [], &block)
    if level_arr[0] == nil && keep_arr != []
     return keep_arr
    elsif level_arr[0] == nil && keep_arr ==[]
      return
    end

    level_arr << level_arr[0].left_child if level_arr[0].left_child != nil
    level_arr << level_arr[0].right_child if level_arr[0].right_child != nil
    
    if block_given?
      yield(level_arr.shift)
    else
      keep_arr << level_arr.shift.data
    end

    level_order(level_arr, keep_arr, &block)
  end

  def in_order(current_node = @root, keep_arr = [], &block)
    if current_node != nil
      in_order(current_node.left_child, keep_arr, &block)
    else
      return
    end
   
    if block_given?
      yield(current_node.data)
    elsif current_node != nil
      keep_arr << current_node.data
    end

    in_order(current_node.right_child, keep_arr, &block)

    return keep_arr if block_given? == false
  end

  def pre_order(current_node = @root, keep_arr = [], &block)
    if current_node != nil
      if block_given?
        yield(current_node.data)
      else
        keep_arr << current_node.data
      end
    else
      return
    end

    pre_order(current_node.left_child, keep_arr, &block)
    pre_order(current_node.right_child, keep_arr, &block)

    if block_given?
      return
    else
      return keep_arr
    end
  end

  def post_order(current_node = @root, keep_arr = [], &block)
    if current_node != nil
      post_order(current_node.left_child, keep_arr, &block)
      post_order(current_node.right_child, keep_arr, &block)
    else
      return
    end

    if block_given?
      yield(current_node.data)
    elsif current_node != nil
      keep_arr << current_node.data
    end

    if block_given?
      return
    else 
      return keep_arr
    end
  end

  def height(node)
    node = find(node)
    counter = 0

    while node != nil
      counter += 1
      node = node.left_child
    end

    return counter
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end