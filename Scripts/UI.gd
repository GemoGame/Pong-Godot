extends Control

func _set_score_text(left,right):
	$Score/Left.text = str(left)
	$Score/Right.text = str(right)

func _set_win_text(txt):
	$WinCondition.text = txt
