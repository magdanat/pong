extends RigidBody2D

signal hit

@export var speed = 400

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	# Returns a vector
	screen_size = get_viewport_rect().size
	
	# starting position
	var y_position = screen_size.y
	var x_position = screen_size.x - 50
	position = Vector2(x_position, y_position / 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	# check if the ball is in the arena
	# if it is, follow its y position
	
	pass
