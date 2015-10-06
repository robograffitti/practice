(defun setup ()
  (jaxon_jvrc-init)
  (objects (list *jaxon_jvrc*))
  (send *jaxon_jvrc* :reset-manip-pose)
  (send *ri* :angle-vector (send *jaxon_jvrc* :angle-vector) 5000)
  (send *ri* :start-auto-balancer)
  (send *ri* :start-st)
  )

(defun move ()
  (send *ri* :go-pos 3.75 0 0)
  (send *ri* :go-pos 0 0 90.0)
  (send *ri* :go-pos 0 1.0 0) ;; 0.75 ~ 1.25
)

;; lleg_joint0~5
(defun step ()
  (send *jaxon_jvrc* :lleg_joint3 :joint-angle 90)
  (send *jaxon_jvrc* :lleg_joint2 :joint-angle -90)
  (send *jaxon_jvrc* :lleg_joint4 :joint-angle 0)
)

;; (send *ri* :potentio-vector)
