extends Node
const PORT = 7777
const MAX_PLAYERS = 8
var peer: ENetMultiplayerPeer

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_H:
			host_game()
		elif event.keycode == KEY_J:
			join_game("127.0.0.1")

func host_game() -> void:
	if peer != null:
		return
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_PLAYERS)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	print("Hosting on port ", PORT)
	_on_peer_connected(multiplayer.get_unique_id())

func join_game(address: String) -> void:
	if peer != null:
		return
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(func(): print("Connected to server!"))
	print("Joining ", address, ":", PORT)

# spawns player when either creating or joining a lobby
func _on_peer_connected(id: int) -> void:
	if multiplayer.is_server():
		World.getWorld().add_player(id)

func _on_peer_disconnected(id: int) -> void:
	if multiplayer.is_server():
		World.getWorld().remove_player(id)
