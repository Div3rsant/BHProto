extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$circle_spawner.set_active()



func _physics_process(delta):
	rng.randomize()
	
	move_and_collide(Vector2(rng.randf_range(-1, 1),rng.randf_range(-1, 1)))
