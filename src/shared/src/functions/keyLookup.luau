local KeyMap = require(script.Parent.KeyMap)

return function()
	local lookup = {}

	for k, v in KeyMap do
		for _, input in v do
			lookup[input] = k
		end
	end

	return lookup
end
