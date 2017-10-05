static func find_all_targets(Type, root):
	var found = []
	for node in root.get_children():
		if node extends Type:
			found.append(node)
		else:
			var ts = find_all_targets(Type, node)
			for t in ts:
				found.append(t)
	return found