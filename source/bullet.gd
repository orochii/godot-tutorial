extends Area2D

@export var life:float
@export var damage:int
@export var speed:float
var bullet_source

func setup(source, reference:AnimatedSprite2D) -> void:
	bullet_source = source
	var shoot_offset = source.shoot_offset
	if reference.flip_h:
		shoot_offset.x *= -1
	global_position = reference.global_position + shoot_offset
	$Sprite2D.flip_h = reference.flip_h

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = -1.0
	if $Sprite2D.flip_h:
		direction = 1.0
	var move = Vector2(speed * delta * direction, 0)
	global_position += move
	life -= delta
	if life < 0:
		queue_free()
	pass

func _on_body_entered(body: Node2D) -> void:
	if body != bullet_source:
		queue_free()
		pass
