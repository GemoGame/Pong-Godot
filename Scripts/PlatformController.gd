extends Node2D

onready var left_platform = $LeftPlatform
onready var right_platform = $RightPlatform
onready var left_default_pos = Vector2(124,300)
onready var right_default_pos = Vector2(900,300)
onready var current_input = "" #inisialisasi state input
onready var score = {	"left" 	: 0,
						"right" : 0}

export (Vector2) var velocity = Vector2(0,700)
export (int) var score_to_win = 5

func _ready():
	left_platform.position = left_default_pos
	right_platform.position = right_default_pos
	
func _process(delta):
	#pastikan input keybinding sebelumnya sudah di-setting untuk masing masing input yang digunakan
	#input_up 	= tombol arah atas
	#input_down = tombol arah bawah
	
	if Input.is_action_just_pressed("input_up") or Input.is_action_just_released("input_down"):
		current_input = "up"
		
	if Input.is_action_just_pressed("input_down") or Input.is_action_just_released("input_up"):
		current_input = "down"
	
	#platform akan berhenti bergerak jika tombol "input_down" dan "input_up" tidak sedang ditekan
	if not Input.is_action_pressed("input_down") and not Input.is_action_pressed("input_up"):
			current_input = ""
			
	_move_platform(delta)

func _move_platform(delta):
	#platform akan bergerak ke atas
	if current_input == "up":
		if velocity.y > 0:
			velocity.y *= -1
		_move_both_platform(velocity, delta)
	
	#platform akan bergerak ke bawah
	elif current_input == "down":
		velocity.y = abs(velocity.y)
		_move_both_platform(velocity, delta)
	
	#platform dihentikan
	elif current_input == "":
		_move_both_platform(Vector2(0,0), delta)
	
func _move_both_platform(vel,delta):
	left_platform.move_and_collide(vel *delta, false)
	right_platform.move_and_collide(vel *delta, false)

#mengecek ketika ada objek yang masuk ke daerah belakang platform kanan
func _on_RightBase_body_entered(body):
	if body == $Ball:
		body.position.x = 1024/2
		body.position.y = 600/2
		score.left += 1
		$UI._set_score_text(score.left,score.right)
		$Ball._initiate_direction()
		_check_score()

#mengecek ketika ada objek yang masuk ke daerah belakang platform kiri
func _on_LeftBase_body_entered(body):
	if body == $Ball:
		body.position.x = 1024/2
		body.position.y = 600/2
		score.right += 1
		$UI._set_score_text(score.left,score.right)
		$Ball._initiate_direction()
		_check_score()

func _check_score():
	if score.left >= score_to_win:
		$UI._set_win_text("Left Wins!")
		get_tree().paused = true # menghentikan permainan
		
	elif score.right >= score_to_win:
		$UI._set_win_text("Right Wins!")
		get_tree().paused = true # menghentikan permainan
