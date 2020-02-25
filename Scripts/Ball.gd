extends KinematicBody2D
export (int) var speed = 500
var direction = Vector2()

func _ready():
	randomize()
	#inisiasi arah awal bola
	_initiate_direction()
	get_tree().paused = true
		
func _initiate_direction():
	direction.x = rand_range(-0.5, 0.5)
	direction.y = rand_range(-0.5, 0.5)

func _process(delta):
	if abs(direction.x) < 0.2:
		direction.x *= 2
	var velocity = (speed * direction) * 100
	var collision = move_and_collide(velocity * delta)
	#mengecek apakah terjadi pantulan dengan objek lain
		#jika ya bola akan memantul berdasarkan arah datang bola dan nilai normal dari koordinat pantulan bola
	if collision != null: 
		direction = direction.bounce(collision.normal) # do ball bounce

func _on_Timer_timeout():
	get_tree().paused = false
