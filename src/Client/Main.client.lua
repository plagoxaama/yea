-- Main: Entry point for the client-side game logic.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIManager = require(ReplicatedStorage.Client.UIManager)
local Remotes = require(ReplicatedStorage.Shared.Remotes)

UIManager:Initialize()

Remotes.UpdateStatus.OnClientEvent:Connect(function(text)
    UIManager:SetStatus(text)
end)
