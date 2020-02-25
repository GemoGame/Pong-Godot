extends KinematicBody2D
export (int) var speed = 500
var direction = Vector2()

func _ready():
	randomize()
	# start with random direction beetween -1 and 1
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
	if collision != null:
		direction = direction.bounce(collision.normal) # do ball bounce

func _on_Timer_timeout():
	get_tree().paused = false
	$FireParticles.emitting = true
	pass # Replace with function body.
