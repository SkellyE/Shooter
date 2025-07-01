extends CharacterBody2D
@onready var laser_timer = $LaserTimer
@onready var grenade_timer = $GrenadeTimer

signal laser_shot(pos, direction)
signal grenade_shot(pos,direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_just_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_markers := $StartPostions.get_children()
		var selected_laser := laser_markers[randi() % laser_markers.size()]
		laser_shot.emit(selected_laser.global_position, player_direction)
		can_laser = false
		laser_timer.start()
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var grenade_markers := $StartPostions.get_children()
		var selected_grenade := grenade_markers[randi() % grenade_markers.size()]
		grenade_shot.emit(selected_grenade.global_position, player_direction)
		can_grenade = false
		grenade_timer.start()

func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true
