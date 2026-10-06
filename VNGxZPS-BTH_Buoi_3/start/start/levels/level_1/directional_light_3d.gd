extends DirectionalLight3D

@export var day_duration: float = 60 # Time between day and night
var rotation_speed: float # The speed for sun's rotation

func _ready() -> void:
	rotation_speed = 360.0 / day_duration
	pass

func _process(delta: float) -> void:
	# Rotate DirectionalLight3D around X-axis to simulate the sun rise and fall
	rotate_x(deg_to_rad(rotation_speed * delta))
	# Sync the Light Intensity to not let the night too bright
	_update_light_properties()
	
func _update_light_properties() -> void:
	# Check the angle of the light (sun)
	var sun_angle = rotation.x
	
	# Modify Intensity if the sunlight's angle in higher or lower the horizontal line
	if sin(sun_angle) < 0:
		light_energy = 1.0 # Night
		light_color = Color.DARK_BLUE
	else:
		light_energy = lerp(0.0, 2.0, sin(sun_angle)) #Day
		light_color = Color.YELLOW
