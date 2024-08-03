extends Node2D

signal roundStart
signal roundEnd

@export var ball_scene: PackedScene
@export var playerScore = 0
@export var enemyScore = 0
@export var lastScored = 0

var winningScore = 2
var ball

var playerScored = false

# Called when the node enters the scene tree for the first time.
func _ready():
	new_round()

# Should spawn a new ball in the middle of the arena
func new_round():
	ball = ball_scene.instantiate()
	add_child(ball)
	roundStart.emit()

func _on_player_goal_body_entered(body):
	removeBall()
	enemyScore += 1
	lastScored = 2
	$HUD.update_enemy_score(enemyScore)
	checkScore()

func _on_enemy_goal_body_entered(body):
	removeBall()
	playerScore += 1
	lastScored = 1
	$HUD.update_player_score(playerScore)
	checkScore()

func checkScore():
	if playerScore == winningScore:
		endGame("Player")
	elif enemyScore == winningScore:
		endGame("Enemy")
	elif (playerScore < winningScore || enemyScore < winningScore):
		new_round()

func removeBall():
	ball.free()
	roundEnd.emit()

func endGame(victor):
	print(victor + " won")
