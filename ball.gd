extends RigidBody2D

@export var velocity : Vector2
@export var collision_coords : Vector2

# Initial speed of the ball
var initial_speed = 100
# Offset for ball spawn on y-axis
var y_offset = 100
# Used to determine where it spawns
var rng = RandomNumberGenerator.new()

var lastScorer

# Called when the node enters the scene tree for the first time.
# Ideally we will instantiate the ball on the start of a game and a few seconds
# after someone scores
# At the start of a new game, the ball will be given a randomly velocity
# Once someone scores, the ball will go towards the person who was scored against
# to give them the first hit
func _ready():
	var screen_size = get_viewport_rect().size
	
	# initial position
	position = Vector2(screen_size.x / 2, rng.randf_range(0 + y_offset, screen_size.y - y_offset))
	collision_coords = Vector2(position.x, position.y)
	lastScorer = get_parent().lastScored
	
	var direction = rng.randf_range(-400, 400)

	if lastScorer == 1:
		direction = rng.randf_range(-400, 0)
	elif lastScorer == 2:
		direction = rng.randf_range(0, 400)
	
	velocity = Vector2(direction * 2, rng.randf_range(0, 100))
	print("Spawned ball velocity is..." + str(velocity.x))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		collision_coords = Vector2(position.x, position.y)
		var collision_normal = collision.get_normal()
		var reflect = collision.get_remainder().bounce(collision_normal)
		velocity = velocity.bounce(collision_normal)
		move_and_collide(reflect)
