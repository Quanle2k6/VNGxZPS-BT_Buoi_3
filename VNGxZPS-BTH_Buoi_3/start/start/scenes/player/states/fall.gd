extends PlayerState
var coyote_timer: float

func _enter() -> void:
	#Change animation to fall
	obj.change_animation("fall")
	coyote_timer = 0.0
	pass

func _update(_delta: float) -> void:
	#Control moving
	var is_moving: bool = control_moving()
	#If on floor change to idle if not moving and not jumping and modify jump_count and had_jump
	if obj.is_on_floor():
		if not is_moving and not control_jump():
			change_state(fsm.states.idle)
			obj.jump_count = 0
			obj.had_jump = false
	#If fall at the edge of cliff or block then start the coyote timer
	if obj.was_on_floor and not obj.is_on_floor() and obj.velocity.y >= 0:
		coyote_timer = obj.COYOTE_TIME
	# Update coyote timer
	coyote_timer -= _delta
	#print_debug(coyote_timer)
	if coyote_timer > 0:
		control_jump()
	# Just double jump if had jump before
	if obj.had_jump and obj.jump_count < 2:
		control_jump()
	pass
