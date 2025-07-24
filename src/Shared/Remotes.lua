-- Remotes: Defines the remote events and functions used in the game.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = {
    UpdateStatus = Instance.new("RemoteEvent", ReplicatedStorage)
}
Remotes.UpdateStatus.Name = "UpdateStatus"

return Remotes
