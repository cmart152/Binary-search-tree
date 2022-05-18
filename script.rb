require_relative './lib/tree'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 34, 36, 79, 23]

number_tree = Tree.new(arr)
number_tree.pretty_print
p number_tree.depth(4)