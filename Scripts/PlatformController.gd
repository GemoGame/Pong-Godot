extends Node2D

onready var left_platform = $LeftPlatform
onready var right_platform = $RightPlatform
onready var left_default_pos = Vector2(124,300)
onready var right_default_pos = Vector2(900,300)
onready var current_input = ""
onready var score = {	"left" 	: 0,
						"right" : 0}

export (Vector2) var velocity = Vector2(0,700)
export (int) var score_to_win = 5

func _ready():
	left_platform.position = left_default_pos
	right_platform.position = right_default_pos
	
func _process(delta):
	
	if Input.is_action_just_pressed("input_up") or Input.is_action_just_released("input_down"):
		current_input = "up"
		
	if Input.is_action_just_pressed("input_down") or Input.is_action_just_released("input_up"):
		current_input = "down"
		
	if not Input.is_action_pressed("input_down") and not Input.is_action_pressed("input_up"):
			current_input = ""
			
	_move_platform(delta)


func _move_platform(delta):
	if current_input == "up":
		if velocity.y > 0:
			velocity.y *= -1
		_move_both_platform(velocity, delta)
		
	elif current_input == "down":
		velocity.y = abs(velocity.y)
		_move_both_platform(velocity, delta)
		
	elif current_input == "":
		_move_both_platform(Vector2(0,0), delta)
	

func _move_both_platform(vel,delta):
	left_platform.move_and_collide(vel *delta, false)
	right_platform.move_and_collide(vel *delta, false)


func _check_platform_pos(pos):
	if left_platform.position.y <= 0  and velocity.y > 0:
		return true
	elif left_platform.position.y >= 480 and velocity.y < 0:
		return true
	return false


func _on_RightBase_body_entered(body):
	if body == $Ball:
		body.position.x = 1024/2
		body.position.y = 600/2
		score.left += 1
		$Control._set_score_text(score.left,score.right)
		$Ball._initiate_direction()
		_check_score()

func _on_LeftBase_body_entered(body):
	if body == $Ball:
		body.position.x = 1024/2
		body.position.y = 600/2
		score.right += 1
		$Control._set_score_text(score.left,score.right)
		$Ball._initiate_direction()
		_check_score()

func _check_score():
	if score.left >= score_to_win:
		$Control._set_win_text("Left Wins!")
		get_tree().paused = true
		
	elif score.right >= score_to_win:
		$Control._set_win_text("Right Wins!")
		get_tree().paused = true
