-- UIManager: Manages the game's UI.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage.Shared
local Events = require(Shared.Events)

local UIManager = {}

function UIManager:Initialize()
    -- Create the main screen GUI
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create the status label
    self.StatusLabel = Instance.new("TextLabel")
    self.StatusLabel.Name = "StatusLabel"
    self.StatusLabel.Size = UDim2.new(0, 400, 0, 50)
    self.StatusLabel.Position = UDim2.new(0.5, -200, 0, 0)
    self.StatusLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    self.StatusLabel.BackgroundTransparency = 0.5
    self.StatusLabel.TextColor3 = Color3.new(1, 1, 1)
    self.StatusLabel.Font = Enum.Font.SourceSansBold
    self.StatusLabel.TextSize = 24
    self.StatusLabel.Text = "Waiting for players..."
    self.StatusLabel.Parent = self.ScreenGui
end

function UIManager:SetStatus(text)
    self.StatusLabel.Text = text
end

return UIManager
