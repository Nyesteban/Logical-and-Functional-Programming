(defun remove_numeric(l)
	(cond
		((listp l) (list (mapcan #'remove_numeric l)))
		((and (numberp l) (equal (mod l 3) 0)) nil)
		(t (list l))
	)
)

(defun main_func(l)
	(mapcan #'remove_numeric l)
)