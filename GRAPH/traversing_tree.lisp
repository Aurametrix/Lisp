(defun make-tree (data)
  "Creates a new node that contains 'data' as its data."
  ...)

(defun add-child (tree child)
  "Takes two nodes created with 'make-tree' and adds the
  second node as a child of the first. Returns the first node,
  which will be modified."
  ...)

(defun first-child (tree)
  "Returns a reference to the first child of the node passed in,
  or nil if this node does not have children."
  ...)

(defun next-sibling (tree)
  "Returns a reference to the next sibling of the node passed in,
  or nil if this node does not have any siblings."
  ...)

(defun data (tree)
  "Returns the information contained in this node."
  ...)
