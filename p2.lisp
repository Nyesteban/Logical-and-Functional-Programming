; 2. Return the list of nodes on the k-th level of a tree of type (1).

; traverse_left flow model: (i,i,i)
(defun traverse_left(arb nv nm)
    (cond
        ((null arb) nil)
        ((= nv (+ 1 nm)) nil)
        (t (cons (car arb) (cons (cadr arb) (traverse_left (cddr arb) (+ 1 nv) (+ (cadr arb) nm)) ) ) )
    )
)

; left flow model: (i)
(defun left(arb)
    (traverse_left (cddr arb) 0 0)
)

; traverse_right flow model: (i,i,i)
(defun traverse_right(arb nv nm)
    (cond
        ((null arb) nil)
        ((= nv (+ 1 nm)) arb)
        (t (traverse_right (cddr arb) (+ 1 nv) (+ (cadr arb) nm)) )  
    )
)

; right flow model: (i)
(defun right(arb)
    (traverse_right (cddr arb) 0 0)
)

; kth_level flow model: (i,i,i)
(defun kth_level(arb level k) 
    (cond
        ((null arb) nil)
        ((= level k) (list(car arb)) )
        (t (append (kth_level (left arb) (+ 1 level) k) (kth_level (right arb) (+ 1 level) k) ))
    )
)

; kth_main flow model: (i,i)
(defun kth_main(arb k)
	(kth_level arb 0 (- k 1))
)

; Tests

(defun test_kth_main()
    (assert (equal (kth_main '(A 2 B 0 C 2 D 0 E 0) 2) '(B C)))
    (assert (equal (kth_main '(A 2 B 0 C 2 D 0 E 0) 3) '(D E)))
    (assert (equal (kth_main '(A 2 B 0 C 2 D 0 E 0) 1) '(A)))
    (assert (equal (kth_main '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0) 2) '(b d)))
    (assert (equal (kth_main '(a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0) 3) '(c f e h)))
)

(defun test_all()
    (test_kth_main)
)

(test_all)