extends RigidBody2D

@export var speed = 400

# Shorthand for doing the work inside _ready() function
@onready var paddle_size = get_node("CollisionShape2D").shape.size

var screen_size
var ball

# Called when the node enters the scene tree for the first time.
func _ready():
	print(paddle_size)
	# Returns a vector
	screen_size = get_viewport_rect().size
	
	# Get reference to the ball
	# Should only do this on a new game start
	ball = get_parent().get_node("Ball")
	
	# starting position
	var y_position = screen_size.y
	var x_position = screen_size.x - 50
	position = Vector2(x_position, y_position / 2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	# check if the ball is in the arena
	if (ball): 
		var current_position = position.y
		
		# middle of the paddle should be 
		# near the y-intercept
		
		# we know the velocity
		if (ball.velocity.x < 0):
			# on top side of screen
			if (current_position < (screen_size.y / 2) + (paddle_size.y / 10)):
				velocity.y +=1
			# bottom side of the screen
			if (current_position > (screen_size.y / 2) - (paddle_size.y / 10)):
				velocity.y -= 1
		elif ball.velocity.x > 0:
			
			# determine y_intercept
			var slope = ball.velocity.y / ball.velocity.x
			var x_diff = position.x - ball.collision_coords.x
			var y_intercept = x_diff * slope + ball.collision_coords.y
			
			# want the y_intercept be between the range of the paddle size
			# go down
			
			# above the y_intercept
			if current_position < y_intercept + (paddle_size.y / 10):
				velocity.y += 1
			# go up
			if current_position > y_intercept - (paddle_size.y / 10):
				velocity.y -= 1
				
		if (velocity.length() > 0):
			velocity = velocity.normalized() * speed
	
	move_and_collide(velocity * delta)
