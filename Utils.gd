static func find_all_nodes(Type, root):
	var found = []
	for node in root.get_children():
		if node extends Type:
			found.append(node)
		else:
			var ts = find_all_nodes(Type, node)
			for t in ts:
				found.append(t)
	return found
	
static func name_from_root(name = null):
	return '/root/Root' + ('/' + name if name else '');
	
# polyfill for draw_line, as it's broken in browser builds
static func m_draw_line(obj, from, to, color, thickness):
	obj.draw_rect(Rect2(from - Vector2(0, thickness/2), Vector2((to - from).length(), thickness)), color)
	
static func m_draw_line_p(obj, from, to, color, thickness):
	obj.draw_primitive(Vector2Array([from, to]), ColorArray([color, color]), Vector2Array([]), null, 3 * thickness)