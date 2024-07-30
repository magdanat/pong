extends Node2D

signal hit

@export var speed = 400

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	# Returns a vector
	screen_size = get_viewport_rect().size
	
	# starting position
	var y_position = screen_size.y
	position = Vector2(100, y_position / 2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	# Calculate the speed 
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	# Update the actual position of the paddle
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
