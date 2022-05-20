require_relative './lib/tree'

arr = [97, 9, 12, 46, 84, 23, 57, 49, 65, 1, 20, 2, 24, 61, 15]

number_tree = Tree.new(arr)
number_tree.pretty_print
p number_tree.balanced?
p number_tree.post_order
p number_tree.pre_order
p number_tree.level_order
p number_tree.in_order
number_tree.insert(34)
number_tree.insert(56)
number_tree.insert(789)
number_tree.insert(2)
number_tree.insert(22)
number_tree.insert(12)
number_tree.insert(4)
number_tree.insert(5)
number_tree.pretty_print
p number_tree.balanced?
number_tree.rebalance
number_tree.pretty_print
p number_tree.balanced?
p number_tree.post_order
p number_tree.pre_order
p number_tree.level_order
p number_tree.in_order