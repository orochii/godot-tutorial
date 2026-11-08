extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var bullet_scene:PackedScene
@export var shoot_offset:Vector2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("action_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle shooting!
	if Input.is_action_just_pressed("action_shoot"):
		print("Shot bullet!")
		var new_bullet = bullet_scene.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.setup(self,$AnimatedSprite2D)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction>0
		$AnimatedSprite2D.animation = "walk"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = "default"

	move_and_slide()
