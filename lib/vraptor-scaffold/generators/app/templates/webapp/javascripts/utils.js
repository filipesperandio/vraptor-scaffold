var Request = function(action, resource) {
	var self = action;
	delete resource.links;
	self.data = resource;
	return self;
};

