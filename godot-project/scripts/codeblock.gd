extends RigidBody2D

## Drag a code block with the mouse; on release it snaps to the nearest
## tile-grid cell. The body is kept frozen (kinematic) so we can position it
## by hand without the physics engine fighting us, and so a placed block
## stays exactly where it was snapped.

@export var snap_to_grid: bool = true

var _tilemap: TileMapLayer
var _dragging: bool = false
var _grab_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	freeze = true
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	input_pickable = true
	_tilemap = get_tree().get_first_node_in_group("tilemap")

# Fires only when the click lands on this body's collision shape -> pick up.
func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_dragging = true
		# Remember where on the block we grabbed, so it doesn't jump to the cursor.
		_grab_offset = global_position - get_global_mouse_position()

# Handled globally so we still get motion/release when the cursor leaves the block.
func _input(event: InputEvent) -> void:
	if not _dragging:
		return
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + _grab_offset
	elif event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		_dragging = false
		_snap()

# Snap this block's origin (its top-left corner) to the nearest cell.
func _snap() -> void:
	if not snap_to_grid or _tilemap == null:
		return
	var cell := _tilemap.local_to_map(_tilemap.to_local(global_position))
	global_position = _tilemap.to_global(_tilemap.map_to_local(cell))
