#!/usr/bin/env roseus
(load "package://peppereus/pepper-interface.l")
(defun setup ()
  (pepper-init)
  (objects (list *pepper*))
  (setq *robot* *pepper*)
  (send *robot* :head-neck-p :joint-angle 0)
  (send *robot* :reset-pose) ;; :init-pose
  (send *irtviewer* :draw-objects)
  ;; x(cm), y(cm), theta(deg)
  ;; (send *ri* :go-pos 0 0 0)
  )

(defun send-pose ()
  (send *ri* :angle-vector (send *robot* :angle-vector) 5000)
  )

(defun send-reset-pose ()
  (send *robot* :reset-pose) ;; :init-pose
  (send *ri* :angle-vector (send *robot* :angle-vector) 5000)
  )

;; convert cooridnate

;; main function
(defun demo ()
  (setup)
  (send-pose)
  )

(setup)

;; (demo)

;; joints
;; :head-neck-p
;; :head-neck-y
;; :knee-p
;; :hip-r
;; :hip-p
;; :rarm-shoulder-p
;; :rarm-shoulder-r
;; :rarm-elbow-y
;; :rarm-elbow-p
;; :rarm-wrist-y
;; :larm-shoulder-p
;: :larm-shoulder-r
;; :larm-elbow-y
;; :larm-elbow-p
;; :larm-wrist-y
