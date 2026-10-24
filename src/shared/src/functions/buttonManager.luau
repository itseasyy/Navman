--\\ BUTTON MANAGER //--
local buttonManager = {}
buttonManager.__index = buttonManager

export type Button = typeof(buttonManager.new())

local _buttons = {} :: { [string]: Button }

function buttonManager.new(id: string)
	local self = setmetatable({}, buttonManager)

	_buttons[id] = self

	return self
end

-- EVENTS
function buttonManager.Fired(self: Button) end

function buttonManager.Selected(self: Button) end

-- TRIGGERS
function buttonManager.Fire(self: Button) end

function buttonManager.Select(self: Button) end

-- SERVICE CODE
function buttonManager._selectButton(id: string)
	local button = _buttons[id]
	if not button then
		warn("Button doesn't exist")
		return
	end

	button:Select()
end

return buttonManager
