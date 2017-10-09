extends TextureFrame

var cache = {}

func set_preview(img_path):
	if cache.has(img_path):
		set_texture(cache[img_path])
	else:
		var img = ImageTexture.new()
		img.load(img_path)
		cache[img_path] = img
		set_texture(img)