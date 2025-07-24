-- PlayerManager: Handles player elimination and spectator mode.

local Players = game:GetService("Players")

local PlayerManager = {}

function PlayerManager:Initialize()
    Players.PlayerRemoving:Connect(function(player)
        -- Handle player leaving during a round
    end)
end

function PlayerManager:OnPlayerDied(player)
    -- Put the player in spectator mode
    self:SetSpectator(player, true)
end

function PlayerManager:SetSpectator(player, isSpectator)
    if isSpectator then
        -- Make the player's character invisible and unable to interact
        if player.Character then
            player.Character:Destroy()
        end
        player.CameraMode = Enum.CameraMode.Scriptable
        -- Simple spectator camera script
        local cameraScript = Instance.new("LocalScript")
        cameraScript.Parent = player.PlayerGui
        cameraScript.Source = [[
            local camera = workspace.CurrentCamera
            local players = game.Players:GetPlayers()
            local currentTarget = 1

            camera.CameraType = Enum.CameraType.Scriptable

            while wait(3) do
                if #players > 0 then
                    local targetPlayer = players[currentTarget]
                    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                        camera.CFrame = CFrame.new(targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 10), targetPlayer.Character.HumanoidRootPart.Position)
                    end
                    currentTarget = (currentTarget % #players) + 1
                end
            end
        ]]
    else
        -- Restore the player's character
        player:LoadCharacter()
        player.CameraMode = Enum.CameraMode.Classic
    end
end

return PlayerManager
