#
# define cloud_instance::dynamic_node
#
# Parameters:
#
# cloud_type, cloud_user, cloud_pass are taken from main class
#
# min_nodes, max_nodes: how many nodes to start as minimum, up to how many nodes
#
# contraint: what is the constraint which is checked for adding new nodes?
# low_constraint: what is the lower boundary (upon which nodes will get deleted again)
# up_constraint: what is the upper boundary (upon which we start adding new nodes)
#
define cloud_instance::dynamic_node (
    $cloud_type = $cloud_instance::cloud_type,
    $cloud_user = $cloud_instance::cloud_user,
    $cloud_pass = $cloud_instance::cloud_pass,
    $min_nodes = 1,
    $max_nodes = 1,
    $constraint = 'load',
    $low_constraint = 1,
    $up_constraint = 4,
){

}
