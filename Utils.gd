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