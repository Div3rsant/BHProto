extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var d = Vector2(0,-1)
var moving = false
var state = {"moving" : "idle", "shooting" : false}
var velocity = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	_process_input()
	

func _process_input():
	if Input.is_action_pressed("down"):
		state["moving"] = "down"
	elif Input.is_action_pressed("left"):
		state["moving"] = "left"
	elif Input.is_action_pressed("up"):
		state["moving"] = "up"
	elif Input.is_action_pressed("right"):
		state["moving"] = "right"
	else:
		state["moving"] = "idle"
	
	if Input.is_action_pressed("shoot"):
		state["shooting"] = true
	else:
		state["shooting"] = false


func _physics_process(delta):
	if state["moving"] != "idle":
		move_and_collide(velocity * get_direction(state["moving"]) * delta)
		
	if state["shooting"]:
		$bullet_manager.fire()
	elif not state["shooting"]:
		$bullet_manager.stop()



func get_direction(movingState):
	if movingState == "down":
		return Vector2(0,1)
	elif movingState == "left":
		return Vector2(-1,0)
	elif movingState == "right":
		return Vector2(1,0)
	elif movingState == "up":
		return Vector2(0,-1)
	elif movingState == "idle":
		return Vector2(0,0)
	else:
		# Might not be a good idea to give back a valid input but at least it 
		# will print something out indicating the state is not recognized
		print("state: " + movingState + " not recognized")
		return Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
