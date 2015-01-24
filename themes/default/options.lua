local options = db.getScreen("options")

options.onEnter = function()
	if options.element then
		options.element.visibility = "Visible"
	end

	-- set input device focus to default widgets...
end

options.onExit = function()
	if options.element then
		options.element.visibility = "Invisible"
	end
end
