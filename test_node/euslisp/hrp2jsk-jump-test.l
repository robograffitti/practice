#!/usr/bin/env roseus
(load "package://hrpsys_ros_bridge_tutorials/euslisp/hrp2jsk-interface.l")

;; (ros::roseus "node_name")
;; (ros::advertise "/topic" geometry_msgs::PointStamped 1)
;; (ros::subscribe "/topic" geometry_msgs::PointStamped #'method-cb)
;; (do-until-key (ros::spin-once))

(defun hrp2-init
  ()
  (hrp2jsk-init)
  (setq *robot* *hrp2jsk*)
  (objects (list *robot*))
  ;; (send *robot* :reset-manip-pose)
  (send *robot* :reset-pose)
  (send *robot* :fix-leg-to-coords (make-coords))  
  ;; (send *robot* :head-neck-p :joint-angle 25)
  ;; (send *robot* :init-pose)
  (send *irtviewer* :draw-objects)
  )

(defun ri-init
  ()
  (send *ri* :angle-vector (send *robot* :angle-vector) 5000)
  (send *ri* :wait-interpolation)
  (send *ri* :start-auto-balancer)
  (send *ri* :wait-interpolation)
  ;; (send *ri* :remove-force-sensor-offset)
  ;; (send *ri* :wait-interpolation)
  ;; (send *ri* :start-st)
  ;; (send *ri* :wait-interpolation)
  ;; (send *ri* :go-pos 0 0 0)
  ;; (send *ri* :wait-interpolation)
  )

(defun st-locomo
  ()
  (send *ri* :remove-force-sensor-offset)
  (send *ri* :wait-interpolation)
  (send *ri* :start-st)
  (send *ri* :wait-interpolation)
  (send *ri* :go-pos 0 0 0)
  (send *ri* :wait-interpolation)
)

(defun demo
  ()
  (hrp2-init)
  (ri-init)
  ;; (st-locomo)
  ;; (jump-test)
  ;;
  )

(defun jump-test
  ;; :move-to :move-coords :inverse-kinematics
  (send *robot* :init-pose)
  (send *ri* :angle-vector (send *robot* :angle-vector) 8000)
  (send *ri* :wait-interpolation)

  (setq *lleg-end* (send *robot* :lleg :end-coords :copy-worldcoords))
  (send *lleg-end* :translate (float-vector 0 0 275))
  (send *robot* :lleg :inverse-kinematics *lleg-end* :rotational-axis :z)
  (send *ri* :angle-vector (send *robot* :angle-vector) 8000)
  (send *ri* :wait-interpolation)

  (send *lleg-end* :translate (float-vector 0 0 -250))
  (send *robot* :lleg :inverse-kinematics *lleg-end* :rotational-axis :z)
  (send *ri* :angle-vector (send *robot* :angle-vector) 0.000001)
  ;; no wait interpolation

  ;; using :joint-angle
  ;; (send *robot* :lleg_joint2 :joint-angle -18.0) ;; default: -26.0+8
  ;; (send *robot* :lleg_joint3 :joint-angle 66.0) ;; 50.0
  ;; (send *robot* :lleg_joint4 :joint-angle -16.0) ;; default: -24.0
  ;; (send *robot* :rleg_joint2 :joint-angle -42.0) ;; default: -26.0
  ;; (send *robot* :rleg_joint3 :joint-angle 66.0) ;; 50.0+16.0
  ;; (send *robot* :rleg_joint4 :joint-angle -40.0) ;; -24.0-16.0
)

(demo)
