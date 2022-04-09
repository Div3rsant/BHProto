extends Node2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bullet_res = load("res://bullet.tscn")
var state = "inactive"
export var numOfSpawns = 1
var radius = Vector2(0, -10)
var spawn_points = []
export var fire_rate = .2
export var rotate_time = .2


# Called when the node enters the scene tree for the first time.
func _ready():
	$fire_rate.wait_time = fire_rate
	$rotate_timer.wait_time = rotate_time
	calculate_spawns()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func calculate_spawns():
	var step = 2 * PI / numOfSpawns
	spawn_points.clear()
	for i in range(numOfSpawns):
		var pos = self.global_position + radius.rotated(step * i)
		var dir = (pos - self.global_position).normalized()
		spawn_points.append({"pos" : pos, "direction" : dir})
		

func rotate(degrees : float):
	var r = deg2rad(degrees)
	radius = radius.rotated(r)
	calculate_spawns()

func set_active():
	state = "active"

func _physics_process(delta):
	if state == "active":
		spawn_bullets()



func spawn_bullets():
	var bullets = []
	var bullet
	if $fire_rate.is_stopped():
		bullet = bullet_res.instance()
		for i in range(numOfSpawns):
			bullets.append(bullet_res.instance())
			
	if bullets.size() == spawn_points.size():
		for i in range(numOfSpawns):
			get_tree().root.get_child(0).add_child(bullets[i])
			bullets[i].set_direction(spawn_points[i]["direction"])
			bullets[i].set_active(spawn_points[i]["pos"], "destroyed")
			bullets[i].set_mask("player")
		$fire_rate.start()
		# kind of innefficient/weird
		$rotate_timer.start()


func _on_fire_rate_timeout():
	$fire_rate.stop()


func _on_rotate_timer_timeout():
	rotate(10)
