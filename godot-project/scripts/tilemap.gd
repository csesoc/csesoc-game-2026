extends TileMapLayer

## Paints a rectangular floor at runtime.
##
## The painted cells are purely cosmetic: the snapping logic in codeblock.gd
## relies only on this layer's tile size (via local_to_map / map_to_local),
## not on which cells exist. You can also paint by hand in the editor using
## the assigned TileSet instead of (or on top of) this.

const SOURCE_ID := 0              # the atlas source in tileset.tres (sources/0)
const TILE := Vector2i(0, 0)      # atlas coords of the floor tile
const HALF_WIDTH := 20            # cells painted left/right of origin
const HALF_HEIGHT := 13           # cells painted up/down of origin

func _ready() -> void:
	for x in range(-HALF_WIDTH, HALF_WIDTH + 1):
		for y in range(-HALF_HEIGHT, HALF_HEIGHT + 1):
			set_cell(Vector2i(x, y), SOURCE_ID, TILE)
