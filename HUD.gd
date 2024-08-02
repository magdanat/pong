extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_player_score(score):
	$PlayerScore.text = str(score)
	
func update_enemy_score(score):
	$EnemyScore.text = str(score)
