extends PlayerState

func _enter() -> void:
	#Change animation to jump
	obj.change_animation("jump")
	pass

func _update(_delta: float):
	#Control moving
	control_moving()
	#If velocity.y is less than 0 change to fall
	if obj.velocity.y < 0:
		change_state(fsm.states.fall)
	# Double jump
	if obj.jump_count < 2:
		control_jump()


	pass
