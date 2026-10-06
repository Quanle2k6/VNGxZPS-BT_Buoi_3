extends PlayerState
@export var lerp_speed: float = 10.0 # Transition speed between walking and sprinting

func _enter() -> void:
	#Change animation to run
	obj.change_animation("run")
	pass

func _update(delta: float):
	#Control jump
	if control_jump():
		return
	#Control moving and if not moving change to idle
	if not control_moving():
		change_state(fsm.states.idle)
		return
	#If not on floor change to fall
	if not obj.is_on_floor():
		change_state(fsm.states.fall)
		return
	# Calculate target movement speed and animation speed scale
	var target_speed: float = obj.base_movement_speed
	var target_anim_speed: float = 1.0
	
	if Input.is_action_pressed("sprint"):
		target_speed *= obj.sprint_multiplier
		target_anim_speed = obj.sprint_multiplier
	
	# Smoothly interpolate current speed towards target speed
	obj.movement_speed = lerp(obj.movement_speed, target_speed, lerp_speed * delta)
	
	# Update AnimationPlayer speed_scale (assuming AnimationPlayer is located on obj)
	if obj.has_node("AnimationPlayer"):
		var anim_player = obj.get_node("AnimationPlayer")
		anim_player.speed_scale = lerp(anim_player.speed_scale, target_anim_speed, lerp_speed * delta)
	pass
