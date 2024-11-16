local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomMenu"
screenGui.Parent = player:WaitForChild("PlayerGui")

local menuButton = Instance.new("TextButton")
menuButton.Name = "Menu"
menuButton.Size = UDim2.new(0, 100, 0, 50)
menuButton.Position = UDim2.new(0, 10, 0, 10)
menuButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuButton.TextColor3 = Color3.fromRGB(85, 255, 0)
menuButton.Font = Enum.Font.PressStart2P
menuButton.TextScaled = true
menuButton.Text = "Menu"
menuButton.Parent = screenGui

local function createButton(name, size, position, backColor, textColor, text, strokeColor)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset)
    button.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset)
    button.BackgroundColor3 = backColor
    button.TextColor3 = textColor
    button.Font = Enum.Font.PressStart2P
    button.TextScaled = true
    button.Text = text

    local uiStroke = Instance.new("UIStroke")
    uiStroke.StrokeMode = Enum.StrokeMode.Border
    uiStroke.Color = strokeColor
    uiStroke.Parent = button

    return button
end

local movableFrame = Instance.new("Frame")
movableFrame.Name = "MovableFrame"
movableFrame.Size = UDim2.new(0, 598, 0, 330)
movableFrame.Position = UDim2.new(0.5, -299, 0.5, -165)
movableFrame.AnchorPoint = Vector2.new(0.5, 0.5)
movableFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
movableFrame.BackgroundTransparency = 0.2
movableFrame.Visible = false
movableFrame.Parent = screenGui

local movableFrameStroke = Instance.new("UIStroke")
movableFrameStroke.StrokeMode = Enum.StrokeMode.Border
movableFrameStroke.Color = Color3.fromRGB(85, 255, 0)
movableFrameStroke.Parent = movableFrame

local buttons = {
    {name = "Sphere", size = Vector2.new(131, 50), position = Vector2.new(0.146, 0.407), backColor = Color3.new(0, 0, 0), textColor = Color3.fromRGB(255, 255, 0), text = "Doodle Sphere", strokeColor = Color3.fromRGB(255, 255, 0), teleport = CFrame.new(-5533, 105, -98)},
    {name = "AntiVoid", size = Vector2.new(131, 50), position = Vector2.new(0.146, 0.04), backColor = Color3.fromRGB(255, 255, 255), textColor = Color3.new(0, 0, 0), text = "Anti-Void", strokeColor = Color3.new(0, 0, 0), teleport = CFrame.new(-3911, 105, -116)},
    {name = "Battle", size = Vector2.new(131, 50), position = Vector2.new(0.146, 0.78), backColor = Color3.new(0, 0, 0), textColor = Color3.new(255, 255, 255), text = "Battle Place", strokeColor = Color3.new(255, 255, 255), teleport = CFrame.new(-2057, 6, 148)},
    {name = "Loadscreen", size = Vector2.new(131, 50), position = Vector2.new(0.601, 0.04), backColor = Color3.new(0, 0, 0), textColor = Color3.new(255, 255, 255), text = "Load Screen", strokeColor = Color3.new(255, 255, 255), teleport = CFrame.new(3039, 269, 11554)},
    {name = "Mainframe", size = Vector2.new(131, 50), position = Vector2.new(0.601, 0.407), backColor = Color3.new(0, 0, 0), textColor = Color3.new(255, 255, 255), text = "Mainframe", strokeColor = Color3.new(0, 0, 255), teleport = CFrame.new(-3788, 105, 3100)},
    {name = "Gaster", size = Vector2.new(131, 50), position = Vector2.new(0.601, 0.78), backColor = Color3.new(0, 0, 0), textColor = Color3.new(255, 255, 255), text = "Gaster", strokeColor = Color3.new(255, 255, 255), teleport = CFrame.new(-1086, 570, 1121)},
}

for _, info in pairs(buttons) do
    local button = createButton(info.name, UDim2.new(0, info.size.X, 0, info.size.Y), UDim2.new(info.position.X, 0, info.position.Y, 0), info.backColor, info.textColor, info.text, info.strokeColor)
    button.Parent = movableFrame
    button.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = info.teleport
        end
    end)
end

local closeButton = createButton("close", UDim2.new(0, 35, 0, 17), UDim2.new(0.933, 0, 0, 0), Color3.new(0, 0, 0), Color3.fromRGB(85, 255, 0), "x", Color3.fromRGB(85, 255, 0))
closeButton.Parent = movableFrame
closeButton.MouseButton1Click:Connect(function()
    movableFrame:Destroy()
end)

menuButton.MouseButton1Click:Connect(function()
    movableFrame.Visible = not movableFrame.Visible
end)

local dragging = false
local dragInput, dragStart, startPos

movableFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = movableFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

movableFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        movableFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
