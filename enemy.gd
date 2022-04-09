extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var state = "inactive"

# Called when the node enters the scene tree for the first time.
func _ready():
	state = "active"
	$circle_spawner.set_active()



func _physics_process(delta):
	match state:
		"active":
				rng.randomize()
				var coll = move_and_collide(Vector2(rng.randf_range(-1, 1),rng.randf_range(-1, 1)))
				handle_coll(coll)
		"inactive":
			queue_free()
	

func handle_coll(coll : KinematicCollision2D):
	if coll:
		print("hit")
