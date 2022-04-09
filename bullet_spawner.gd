extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bullet_res = load("res://bullet.tscn")
var state = "inactive"
var spawn_points = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_active():
	state = "active"

func _physics_process(delta):
	if state == "active":
		spawn_bullets()



func spawn_bullets():
	var bullet
	if $fire_rate.is_stopped():
		bullet = bullet_res.instance()

	if bullet:
		print("fired")
		get_tree().root.get_child(0).add_child(bullet)
		bullet.set_direction(Vector2(0, 1))
		bullet.set_active(self.global_position, "destroyed")
		$fire_rate.start()

func _on_fire_rate_timeout():
	$fire_rate.stop()
