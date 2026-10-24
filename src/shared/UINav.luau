--\\ SERVICES //--
local UserInputService = game:GetService("UserInputService")

--\\ FOLDERS //--
local p = script.Parent

--\\ MODULES //--
local keyLookup = require(p.src.functions.keyLookup)
local buttonManager = require(p.src.functions.buttonManager)

--\\ MAIN //--
local main = {}

export type NavContext = {
	Type: string, -- LIST | GRID
	Default: string, --Default button id

	-- TYPE: LIST
	Direction: string, -- HORIZONTAL | VERTICAL

	RightInput: () -> (), -- Action right input (up input in a horizontal list) does
	LeftInput: () -> (), -- Action left input (down input in a horizontal list) does

	List: { string },
}

local _currentButtonId = "" :: string
local _currentContext = {} :: NavContext
local _lookup: { [Enum.KeyCode]: string }

-- MAIN SERVICE CODE

function main.Init()
	_lookup = keyLookup()

	UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if gameProcessedEvent then
			return
		end

		if not _currentContext or next(_currentContext) == nil then
			return
		end

		local Input = _lookup[input.KeyCode]

		if _currentContext["Type"]:lower() == "list" then
			local direction = _currentContext["Direction"]:lower()

			if direction ~= "horizontal" and direction ~= "vertical" then
				warn("Passed improper direction")
				return
			end

			local upDirection = direction == "vertical" and "Up" or "Right"
			local downDirection = direction == "vertical" and "Down" or "Left"

			if Input == `{upDirection}Input` then
				print("hell yea")
			end
		end
	end)
end

function main.UseContext(context: NavContext)
	_currentContext = context

	_currentButtonId = context["Default"]
end

-- BUTTON MANAGER

function main.NewButton(id: string)
	return buttonManager.new(id)
end

return main
