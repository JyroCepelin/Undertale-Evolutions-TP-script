local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "CustomGui"

local menuButton = Instance.new("TextButton", screenGui)
menuButton.Name = "Menu"
menuButton.Size = UDim2.new(0, 80, 0, 40)
menuButton.Position = UDim2.new(0, 10, 0, 100)
menuButton.Text = "Menu"
menuButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuButton.TextColor3 = Color3.fromRGB(85, 255, 0)
menuButton.TextScaled = true
menuButton.Font = Enum.Font.SourceSans
local menuStroke = Instance.new("UIStroke", menuButton)
menuStroke.Color = Color3.fromRGB(85, 255, 0)

local movableFrame = Instance.new("Frame", screenGui)
movableFrame.Name = "MovableFrame"
movableFrame.Size = UDim2.new(0, 598, 0, 330)
movableFrame.Position = UDim2.new(0.5, -299, 0.5, -165)
movableFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
movableFrame.BackgroundTransparency = 0.2
movableFrame.Visible = false
local frameStroke = Instance.new("UIStroke", movableFrame)
frameStroke.Color = Color3.fromRGB(85, 255, 0)

local function createButton(name, position, size, backColor, textColor, strokeColor, text)
	local button = Instance.new("TextButton", movableFrame)
	button.Name = name
	button.Size = UDim2.new(0, size[1], 0, size[2])
	button.Position = UDim2.new(position[1], 0, position[2], 0)
	button.BackgroundColor3 = Color3.fromRGB(backColor[1], backColor[2], backColor[3])
	button.TextColor3 = Color3.fromRGB(textColor[1], textColor[2], textColor[3])
	button.Text = text
	button.TextScaled = true
	button.FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json")
	local stroke = Instance.new("UIStroke", button)
	stroke.Color = Color3.fromRGB(strokeColor[1], strokeColor[2], strokeColor[3])
	return button
end

local buttonData = {
	{name = "Sphere", position = {0.146, 0.407}, size = {131, 50}, backColor = {0, 0, 0}, textColor = {255, 255, 0}, strokeColor = {255, 255, 0}, text = "Doodle sphere", cframe = CFrame.new(-5533, 105, -98)},
	{name = "AntiVoid", position = {0.146, 0.04}, size = {131, 50}, backColor = {255, 255, 255}, textColor = {0, 0, 0}, strokeColor = {0, 0, 0}, text = "Anti-Void", cframe = CFrame.new(-3911, 105, -116)},
	{name = "Battle", position = {0.146, 0.78}, size = {131, 50}, backColor = {0, 0, 0}, textColor = {255, 255, 255}, strokeColor = {255, 255, 255}, text = "Battle place", cframe = CFrame.new(-2057, 6, 148)},
	{name = "Loadscreen", position = {0.601, 0.04}, size = {131, 50}, backColor = {0, 0, 0}, textColor = {255, 255, 255}, strokeColor = {255, 255, 255}, text = "Load Screen", cframe = CFrame.new(3039, 269, 11554)},
	{name = "Mainframe", position = {0.601, 0.407}, size = {131, 50}, backColor = {0, 0, 0}, textColor = {255, 255, 255}, strokeColor = {0, 0, 255}, text = "Mainframe", cframe = CFrame.new(-3788, 105, 3100)},
	{name = "Gaster", position = {0.601, 0.78}, size = {131, 50}, backColor = {0, 0, 0}, textColor = {255, 255, 255}, strokeColor = {255, 255, 255}, text = "Gaster", cframe = CFrame.new(-1086, 570, 1121)},
	{name = "close", position = {0.933, 0}, size = {35, 17}, backColor = {0, 0, 0}, textColor = {85, 255, 0}, strokeColor = {85, 255, 0}, text = "x"}
}

for _, data in ipairs(buttonData) do
	local button = createButton(data.name, data.position, data.size, data.backColor, data.textColor, data.strokeColor, data.text)
	if data.name == "close" then
		button.MouseButton1Click:Connect(function()
			screenGui:Destroy()
		end)
	elseif data.cframe then
		button.MouseButton1Click:Connect(function()
			local character = player.Character
			if character and character:FindFirstChild("HumanoidRootPart") then
				character.HumanoidRootPart.CFrame = data.cframe
			end
		end)
	end
end

menuButton.MouseButton1Click:Connect(function()
	movableFrame.Visible = not movableFrame.Visible
end)

local dragging = false
local dragStart, startPos

movableFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = movableFrame.Position
	end
end)

movableFrame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		movableFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

movableFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
