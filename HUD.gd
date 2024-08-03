extends CanvasLayer

func update_player_score(score):
	$PlayerScore.text = str(score)
	
func update_enemy_score(score):
	$EnemyScore.text = str(score)
