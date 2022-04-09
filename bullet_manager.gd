extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet_res = load("res://bullet.tscn")
var bullets = []
var ammocount = 5
var state = "inactive"
export var fire_vel = 80.0
export var fire_rate = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$fire_rate.wait_time = fire_rate
	for i in ammocount:
		var b = bullet_res.instance()
		bullets.append(b)
		get_tree().root.get_child(0).call_deferred("add_child", b)

func fire():
	state = "active"

func stop():
	state = "inactive"

func _physics_process(delta):
	if state == "active":
		fire_bullets()
	if state == "destroyed":
		queue_free()

func fire_bullets():
	var bullet
	if $fire_rate.is_stopped():
		for b in bullets:
			if b.get_state() == "inactive":
				bullet = b
				break
	
	if bullet:
		bullet.set_active(self.global_position)
		bullet.set_velocity(fire_vel)
		$fire_rate.start()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_fire_rate_timeout():
	$fire_rate.stop()
