extends RigidBody2D

# Initial speed of the ball
var initial_speed = 50
var velocity : Vector2

# Called when the node enters the scene tree for the first time.
# Ideally we will instantiate the ball on the start of a game and a few seconds
# after someone scores
# At the start of a new game, the ball will be given a randomly velocity
# Once someone scores, the ball will go towards the person who was scored against
# to give them the first hit
func _ready():
	
	# if the player scored...go left
	# if the ai scored...go right
	
	# both checks failed, so give a random velocity
	velocity = Vector2(-100, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(reflect)
