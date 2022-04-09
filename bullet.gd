extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var state = "inactive"
var velocity = 80.0
var direction = Vector2(0,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = get_parent().position
	set_inactive()

func set_velocity(v : float):
	velocity = v

func set_active(pos):
	self.position = pos
	$Sprite.visible = true
	$CollisionShape2D.disabled = false
	state = "active"
	
func set_mask(masktype : String):
	match masktype:
		"enemy":
			set_collision_mask_bit(3, false)
			set_collision_mask_bit(2, true)
		"player":
			set_collision_mask_bit(3, true)
			set_collision_mask_bit(2, false)

func set_direction(direction: Vector2):
	self.direction = direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	match state:
		"active":
			move(delta)
		"destroyed":
			queue_free()
		"inactive":
			pass
			
func get_state():
	return state

func destroy():
	state = "destroyed"

func set_inactive():
	$Sprite.visible = false
	$CollisionShape2D.disabled = true
	state = "inactive"

func move(delta):
	var movVec = direction * velocity * delta
	var coll = move_and_collide(movVec)
	
	if coll:
		print("collided with" + coll.collider.name)
		set_inactive()
