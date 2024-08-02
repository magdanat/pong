extends RigidBody2D

@export var speed = 100

# Shorthand for doing the work inside _ready() function
@onready var paddle_size = get_node("CollisionShape2D").shape.size

var screen_size
var ball

# Called when the node enters the scene tree for the first time.
func _ready():
	# Returns a vector
	screen_size = get_viewport_rect().size
	
	var y_position = screen_size.y
	var x_position = screen_size.x - 50
	position = Vector2(x_position, y_position / 2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var velocity = Vector2.ZERO
	var current_position = position.y
	
	if ball != null:
		if ball.velocity.x < 0:
			if (current_position < (screen_size.y / 2) + (paddle_size.y / 10)):
				velocity.y +=1
			if (current_position > (screen_size.y / 2) - (paddle_size.y / 10)):
				velocity.y -= 1
		elif ball.velocity.x > 0:
			var slope = ball.velocity.y / ball.velocity.x
			var x_diff = position.x - ball.collision_coords.x
			var y_intercept = x_diff * slope + ball.collision_coords.y
			
			if current_position < y_intercept + (paddle_size.y / 10):
				velocity.y += 1
			if current_position > y_intercept - (paddle_size.y / 10):
				velocity.y -= 1
		if (velocity.length() > 0):
			velocity = velocity.normalized() * speed
				
	move_and_collide(velocity * delta)

func _on_main_round_start():
	print("Round started")
	ball = get_parent().get_node("Ball")
	print(ball)

func _on_main_round_end():
	ball = null
	print("Round ended")
