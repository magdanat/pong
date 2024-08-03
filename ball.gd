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

func _ready():
	var screen_size = get_viewport_rect().size
	
	# initial position
	position = Vector2(screen_size.x / 2, rng.randf_range(0 + y_offset, screen_size.y - y_offset))
	collision_coords = Vector2(position.x, position.y)
	lastScorer = get_parent().lastScored
	
	var direction = rng.randf_range(-400, 400)

	if lastScorer == 1:
		direction = rng.randf_range(-400, -300)
	elif lastScorer == 2:
		direction = rng.randf_range(300, 400)
	
	velocity = Vector2(direction * 2.2, rng.randf_range(25, 100))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		collision_coords = Vector2(position.x, position.y)
		if (collider.is_in_group("Paddles")):
			var paddlePosition = collider.position
			var relativeBallPosition = collision_coords - paddlePosition
			velocity = relativeBallPosition.normalized() * rng.randf_range(600, 1000)
			move_and_collide(velocity * delta)
		else: 
			var collision_normal = collision.get_normal()
			var reflect = collision.get_remainder().bounce(collision_normal)
			velocity = velocity.bounce(collision_normal)
			move_and_collide(reflect)
