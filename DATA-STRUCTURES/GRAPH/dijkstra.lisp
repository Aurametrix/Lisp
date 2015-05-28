(defun get_helper(index li current_index)
    (cond
        ((eq index current_index) (car li))
        ((eq (length li) current_index) nil)
        (t (get_helper index (cdr li) (+ 1 current_index)))))
 
(defun get_i(index li)
        (get_helper index li 0))
 
(defun is_element_in_list(element li)
    (cond
        ((null li) nil)
        ((eq element (car li)) t)
        (t (is_element_in_list element (cdr li)))))
 
(defun flat_helper(x y)
    (cond
        ((null x) y)
        ((atom x) (cons x y))
        (t (flat_helper (car x) (flat_helper (cdr x) y)))))
 
(defun flat(x)
    (flat_helper x nil))
 
(defun remove_duplicates_helper(x y)
    (cond
        ((null x) y)
        (t (if (is_element_in_list (car x) y) (remove_duplicates_helper (cdr x) y) (remove_duplicates_helper (cdr x) (cons (car x) y))))))
 
(defun remove_duplicates(x)
    (remove_duplicates_helper x nil))
 
(defun remove_many_items(list_of_items list_of_elements)
        (cond
            ((null list_of_items) list_of_elements)
            (t (remove_many_items (cdr list_of_items) (remove (car list_of_items) list_of_elements)))))
 
(defun get_initial_unconnected_nodes_helper(flat_list accum)
    (cond
        ((null flat_list) accum)
        ((atom flat_list) accum)
        (t
            (get_initial_unconnected_nodes_helper (cdddr flat_list) (cons (car flat_list) (cons (cadr flat_list) accum))))))
 
(defun get_initial_unconnected_nodes(start_node list_of_nodes)
    (let ((flatten_list_of_nodes (flat list_of_nodes)))
        (remove start_node (remove_duplicates (get_initial_unconnected_nodes_helper flatten_list_of_nodes nil)))))
 
(defun get_cost(node_1 node_2 list_of_nodes)
    (cond
        ((null list_of_nodes) nil)
        (t  (let((current_tuple (car list_of_nodes)))
            (cond
                    ((and (eq (car current_tuple) node_1) (eq (cadr current_tuple) node_2)) (caddr current_tuple))
                    ((and (eq (car current_tuple) node_2) (eq (cadr current_tuple) node_1)) (caddr current_tuple))
                    (t (get_cost node_1 node_2 (cdr list_of_nodes))))))))
 
(defun get_list_of_neighbors_helper(current_node list_of_nodes accum)
    (cond
        ((null list_of_nodes) accum)
        (t (let ((current_tuple (car list_of_nodes)))
                (cond
                    ((eq (car current_tuple) current_node) (get_list_of_neighbors_helper current_node (cdr list_of_nodes) (cons (cadr current_tuple) accum)))
                    ((eq (cadr current_tuple) current_node) (get_list_of_neighbors_helper current_node (cdr list_of_nodes) (cons (car current_tuple) accum)))
                    (t (get_list_of_neighbors_helper current_node (cdr list_of_nodes) accum)))))))
 
(defun get_list_of_neighbors(current_node list_of_nodes)
    (get_list_of_neighbors_helper current_node list_of_nodes nil))
 
(defun get_list_of_neighbors_in_unconnected_set(current_node list_of_nodes connected_nodes)
    (let ((list_of_neighbors (get_list_of_neighbors current_node list_of_nodes)))
        (remove_many_items connected_nodes list_of_neighbors)))
 
(defun get_cheapest_neighbor_helper(start_node list_of_nodes list_of_neighbors cheapest_node)
    (cond
        ((null list_of_neighbors) cheapest_node)
        (t (let ((current_node (car list_of_neighbors)) (current_cost (get_cost start_node (car list_of_neighbors) list_of_nodes)))
                if (< current_cost (get_cost start_node cheapest_node list_of_nodes))
                    (get_cheapest_neighbor_helper start_node list_of_nodes (cdr list_of_neighbors) current_node)
                    (get_cheapest_neighbor_helper start_node list_of_nodes (cdr list_of_neighbors) cheapest_node)))))
 
(defun get_cheapest_neighbor(current_node list_of_nodes visited_nodes)
    (let ((list_of_neighbors (remove_many_items visited_nodes (get_list_of_neighbors current_node list_of_nodes))))
         get_cheapest_neighbor_helper current_node list_of_nodes list_of_neighbors (car list_of_neighbors)))
 
(defun get_next_node_to_inspect_helper(unconnected_nodes tentative_cost chosen_node)
    (cond
        ((null unconnected_nodes) chosen_node)
        (t (
            let ((current_node (car unconnected_nodes)))
                (if (null (car (assoc current_node tentative_cost)))
                    (get_next_node_to_inspect_helper (cdr unconnected_nodes) tentative_cost chosen_node)
                    (let ((current_cost (cdr (assoc current_node tentative_cost))))
                        (cond
                            ((null chosen_node) (get_next_node_to_inspect_helper (cdr unconnected_nodes) tentative_cost current_node))
                            ((null current_cost) (get_next_node_to_inspect_helper (cdr unconnected_nodes) tentative_cost chosen_node))
                            ((<= current_cost (cdr (assoc chosen_node tentative_cost))) (get_next_node_to_inspect_helper (cdr unconnected_nodes) tentative_cost current_node))
                            (t (get_next_node_to_inspect_helper (cdr unconnected_nodes) tentative_cost chosen_node)))))))))
 
(defun get_next_node_to_inspect(unconnected_nodes tentative_cost)
    (get_next_node_to_inspect_helper unconnected_nodes tentative_cost nil))
 
(defun check_neighbors_and_update_helper(current_node list_of_neighbors list_of_nodes connected_nodes unconnected_nodes desired_tree tentative_cost predecessors)
    (cond
        ((null list_of_neighbors) (dijkstra list_of_nodes connected_nodes unconnected_nodes desired_tree tentative_cost predecessors))
        (t (let ((new_cost (+(cdr(assoc current_node tentative_cost)) (get_cost current_node (car list_of_neighbors) list_of_nodes))) (old_cost (cdr (assoc (car list_of_neighbors) tentative_cost))))
            (cond
                ((null old_cost) (check_neighbors_and_update_helper current_node (cdr list_of_neighbors) list_of_nodes connected_nodes unconnected_nodes desired_tree (acons (car list_of_neighbors) new_cost tentative_cost) (acons (car list_of_neighbors) current_node predecessors)))
                ((< new_cost old_cost) (check_neighbors_and_update_helper current_node (cdr list_of_neighbors) list_of_nodes connected_nodes unconnected_nodes desired_tree (acons (car list_of_neighbors) new_cost tentative_cost) (acons (car list_of_neighbors) current_node predecessors)))
                (t (check_neighbors_and_update_helper current_node (cdr list_of_neighbors) list_of_nodes connected_nodes unconnected_nodes desired_tree tentative_cost predecessors)))))))
 
(defun check_neighbors_and_update(current_node list_of_nodes connected_nodes unconnected_nodes desired_tree tentative_cost predecessors)
    (let ((neighbor_list (get_list_of_neighbors_in_unconnected_set current_node list_of_nodes connected_nodes)))
        (check_neighbors_and_update_helper current_node neighbor_list list_of_nodes connected_nodes unconnected_nodes desired_tree tentative_cost predecessors)))
 
(defun dijkstra(list_of_nodes connected_nodes unconnected_nodes desired_tree tentative_cost predecessors)
    (cond
        ((null unconnected_nodes) (cons desired_tree tentative_cost))
        (t (let((cheapest_neighbor (get_next_node_to_inspect unconnected_nodes tentative_cost)))
                (let ((new_desired_tree (cons (cons cheapest_neighbor (cdr(assoc cheapest_neighbor predecessors))) desired_tree)))
                    (check_neighbors_and_update cheapest_neighbor list_of_nodes (cons cheapest_neighbor connected_nodes) (remove cheapest_neighbor unconnected_nodes) new_desired_tree tentative_cost predecessors))))))
 
(defun organize_individual_entries(list_of_edges accum)
    (cond
        ((null list_of_edges) accum)
        (t (let ((first_entry (caar list_of_edges)) (second_entry (cdar list_of_edges)))
            (if (string> first_entry second_entry)
                (organize_individual_entries (cdr list_of_edges) (cons (cons second_entry first_entry) accum))
                (organize_individual_entries (cdr list_of_edges) (cons (cons first_entry second_entry) accum)))))))
 
(defun list_of_edges_cmp(tuple1 tuple2)
    (let ((node_a_1 (car tuple1))(node_a_2 (cdr tuple1))(node_b_1 (car tuple2))(node_b_2 (cdr tuple2)))
        (cond
            ((string= node_a_1 node_b_1)
                (cond
                    ((string< node_a_2 node_b_2) t)
                    (t nil)))
            ((string< node_a_1 node_b_1) t)
            (t nil))))
 
(defun get_tentative_cost(node_1 node_2 tentative_cost)
    (let ((cost1 (cdr (assoc node_1 tentative_cost))) (cost2 (cdr (assoc node_2 tentative_cost))))
        (if (> cost1 cost2) cost1 cost2)))
 
(defun format_final_output(list_of_sorted_edges tentative_cost accum running_sum)
    (cond
        ((null list_of_sorted_edges) (cons (reverse accum) running_sum))
        (t  (let ((node_1 (caar list_of_sorted_edges)) (node_2 (cdar list_of_sorted_edges)))
                (let ((cost (get_tentative_cost node_1 node_2 tentative_cost)))
                    (let ((prepared_list (cons node_1 (cons node_2 (cons cost nil)))))
                        (format_final_output (cdr list_of_sorted_edges) tentative_cost (cons prepared_list accum) (+ running_sum cost))))))))
 
(defun cheapest_paths(start_node list_of_nodes)
    (let    ((connected_nodes (cons start_node nil))
            (unconnected_nodes (get_initial_unconnected_nodes start_node list_of_nodes))
            (desired_tree nil)
            (tentative_cost (acons start_node 0 nil))
            (predecessors (acons start_node nil nil)))
            ; Send to UPDATE FUNCTION, NOT DIJKSTRA FUNCTION
                (let ((edge_list (check_neighbors_and_update start_node list_of_nodes connected_nodes unconnected_nodes desired_tree tentative_cost predecessors)))
                    (let ((second_format (sort (organize_individual_entries (car edge_list) nil) 'list_of_edges_cmp)))
                        (let ((third_format (format_final_output second_format (cdr edge_list) nil 0)))
                                (append (car third_format) (cons (cdr third_format) nil)))))))
Don’t be alarmed. It’s a lot of text, but I’ll explain it. In fact, it’s actually not too bad; most of the text is composed of generic helper functions that don’t actually impact the algorithm. I’ll still go over all the helper functions, but very briefly.

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
(defun get_helper(index li current_index)
    (cond
        ((eq index current_index) (car li))
        ((eq (length li) current_index) nil)
        (t (get_helper index (cdr li) (+ 1 current_index)))))
 
(defun get_i(index li)
        (get_helper index li 0))
 
(defun is_element_in_list(element li)
    (cond
        ((null li) nil)
        ((eq element (car li)) t)
        (t (is_element_in_list element (cdr li)))))
 
(defun flat_helper(x y)
    (cond
        ((null x) y)
        ((atom x) (cons x y))
        (t (flat_helper (car x) (flat_helper (cdr x) y)))))
 
(defun flat(x)
    (flat_helper x nil))
 
(defun remove_duplicates_helper(x y)
    (cond
        ((null x) y)
        (t (if (is_element_in_list (car x) y) (remove_duplicates_helper (cdr x) y) (remove_duplicates_helper (cdr x) (cons (car x) y))))))
 
(defun remove_duplicates(x)
    (remove_duplicates_helper x nil))
 
(defun remove_many_items(list_of_items list_of_elements)
        (cond
            ((null list_of_items) list_of_elements)
            (t (remove_many_items (cdr list_of_items) (remove (car list_of_items) list_of_elements)))))
