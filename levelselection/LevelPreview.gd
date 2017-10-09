extends TextureFrame

var previews = []

func _ready():
	for i in range(5):
		var img = ImageTexture.new()
		img.load("res://levelselection/img/LevelPreview_"+str(i)+".png")
		previews.append(img)
	set_texture(previews[0])

func set_preview(idx):
	set_texture(previews[idx])