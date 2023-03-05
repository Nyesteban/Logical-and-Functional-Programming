; Define a function to tests the membership of a node in a n-tree represented as (root list_of_nodes_subtree1 ... list_of_nodes_subtreen) 
; Eg. tree is (a (b (c)) (d) (E (f))) and the node is "b" => true

; membership flow model: (i i)
(defun membership (tree e)
    (cond
	((null tree) nil)
	((equal tree e) t)
	((atom tree) nil)
	(t (reduce #'(lambda (x y) (or x y)) (mapcar #'(lambda (tree) (membership tree e)) tree)))
    )
)

; Tests
(defun test_membership()
	(assert (membership '(a (b (c)) (d) (E (f))) 'b))
    	(assert (membership '(a (b (c)) (d) (E (f))) 'f))
    	(assert (not (membership '(a (b (c)) (d) (E (f))) 'G)))
    	(assert (membership '(1 (2 (3 (4 (5 (6 (7 (8 (9 (10)))))))))) '10))
    	(assert (not (membership '((1) (2) (10)) '3)))
)

(defun test_all()
	(test_membership)
)

(test_all)