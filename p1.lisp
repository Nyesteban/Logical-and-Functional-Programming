; a) Write a function to return the n-th element of a list, or NIL if such an element does not exist.

; nth_elem_rec flow model: (i i i)
(defun nth_elem_rec (l n pos)
    (cond
        ((null l) nil)
        ((= n pos) (car l))
        (t (nth_elem_rec (cdr l) n (+ pos 1)))
    )
)

; nth_elem flow model: (i i)
(defun nth_elem (l n)
    (nth_elem_rec l n 1)
)

; b) Write a function to check whether an atom E is a member of a list which is not necessarily linear.

; atom_check flow model: (i i)
(defun atom_check (l e)
    (cond
        ((null l) nil)
        ((and (atom (car l)) (equal (car l) e)) t)
        ((atom (car l)) (atom_check (cdr l) e))
	((list (car l)) (or (atom_check (car l) e) (atom_check (cdr l) e)))
    )
)

; c) Write a function to determine the list of all sublists of a given list, on any level. 

; list_of_sublists flow model: (i)
(defun list_of_sublists (l)
    (cond
	((atom l) nil)
	(t (apply 'append (list l) (mapcar 'list_of_sublists l)))
    )
)

; d) Write a function to transform a linear list into a set.

; remove_elem flow model: (i i)
(defun remove_elem (l e)
    (cond
	((null l) nil)
	((= (car l) e) (remove_elem (cdr l) e))
	(t (cons (car l) (remove_elem (cdr l) e)))
    )
)

; linear_list_to_set flow model: (i)
(defun linear_list_to_set (l)
    (cond
	((null l) nil)
	(t (cons (car l) (linear_list_to_set (remove_elem (cdr l) (car l)))))
    )
)

; Tests
(defun test_nth_elem()
    (assert (equal (nth_elem '(1 2 3 4 5 6 7 8 9 10) 5) 5))
    (assert (equal (nth_elem '(1 2 3 4 5 6 7 8 9 10) 0) nil))
    (assert (equal (nth_elem '(1 2 3 4 5 6 7 8 9 10) 11) nil))
    (assert (equal (nth_elem '(0 1 2 3 4 5 6 7 8 9) 10) 9))
    (assert (equal (nth_elem '(2 2 3) 1) 2))
)

(defun test_atom_check()
    (assert (atom_check '(1 2 3 4 5 6 7 8 9 10) 5))
    (assert (atom_check '(1 2 3 4 5 6 7 8 9 10) 10))
    (assert (not (atom_check '(1 2 3 4 5 6 7 8 9 10) 0)))
    (assert (atom_check '(2 9 7 10 11) 2))
    (assert (not (atom_check '(2 9 7 10 11) 3)))
)

(defun test_list_of_sublists()
    (assert (equal (list_of_sublists '(1 2 (3 (4 5) (6 7)) 8 (9 10))) '( (1 2 (3 (4 5) (6 7)) 8 (9 10)) (3 (4 5) (6 7)) (4 5) (6 7) (9 10) )))
    (assert (equal (list_of_sublists '()) '()))
    (assert (equal (list_of_sublists '(1)) '((1))))
    (assert (equal (list_of_sublists '(1 2 3)) '((1 2 3))))
    (assert (equal (list_of_sublists '(1 (2 (3)))) '((1 (2 (3))) (2 (3)) (3))))
)

(defun test_remove_elem()
    (assert (equal (remove_elem '(1 2 3 4 5 6 7 8 9 10) 5) '(1 2 3 4 6 7 8 9 10)))
    (assert (equal (remove_elem '(1 2 3 4 5 6 7 8 9 10) 10) '(1 2 3 4 5 6 7 8 9)))
    (assert (equal (remove_elem '(1 1 1 1 1) 1) '()))
    (assert (equal (remove_elem '(1 2 1 1 2) 1) '(2 2)))
    (assert (equal (remove_elem '(1 2 3 1 2 3) 3) '(1 2 1 2)))
)

(defun test_linear_list_to_set()
    (assert (equal (linear_list_to_set '(1 2 3 4 5 6 7 8 9 10)) '(1 2 3 4 5 6 7 8 9 10)))
    (assert (equal (linear_list_to_set '(1 2 3 4 5 6 7 8 9 1 1)) '(1 2 3 4 5 6 7 8 9)))
    (assert (equal (linear_list_to_set '(1 1 1 1 1)) '(1)))
    (assert (equal (linear_list_to_set '(1 2 1 1 2)) '(1 2)))
    (assert (equal (linear_list_to_set '(1 2 3 1 2 3)) '(1 2 3)))
)

(defun test_all()
	(test_nth_elem)
	(test_atom_check)
	(test_list_of_sublists)
	(test_remove_elem)
	(test_linear_list_to_set)
)

(test_all)