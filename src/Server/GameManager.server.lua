-- GameManager: Manages the overall game loop, including starting rounds, selecting events, and handling players.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Shared = ReplicatedStorage.Shared
local Events = require(Shared.Events)
local Config = require(Shared.Config)
local PlayerManager = require(ServerScriptService.Server.PlayerManager)
local Remotes = require(ReplicatedStorage.Shared.Remotes)

local GameManager = {}

function GameManager:Initialize()
    PlayerManager:Initialize()
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.Died:Connect(function()
                PlayerManager:OnPlayerDied(player)
            end)
        end)
    end)
end

function GameManager:Start()
    print("GameManager started")

    while true do
        -- Wait for enough players to start the game
        self:WaitForPlayers()

        -- Start the intermission countdown
        self:StartIntermission()

        -- Start a new round
        self:StartRound()
    end
end

function GameManager:WaitForPlayers()
    while #Players:GetPlayers() < Config.MinPlayers do
        Remotes.UpdateStatus:FireAllClients("Waiting for players... (" .. #Players:GetPlayers() .. "/" .. Config.MinPlayers .. ")")
        wait(1)
    end
end

function GameManager:StartIntermission()
    for i = Config.IntermissionDuration, 1, -1 do
        Remotes.UpdateStatus:FireAllClients("Starting in " .. i .. "...")
        wait(1)
    end
end

function GameManager:StartRound()
    print("Starting new round")

    -- Teleport players to the map
    self:TeleportPlayersToMap()

    -- Choose a random event
    local event = Events:GetRandomEvent()
    if not event then
        print("No events registered!")
        return
    end
    print("Selected event: " .. event.Name)
    Remotes.UpdateStatus:FireAllClients("Event: " .. event.Name)

    -- Start the event
    event:Start()

    -- Wait for the event to finish or for a winner
    while not event:IsFinished() and #Players:GetPlayers() > 1 do
        wait(1)
    end

    -- Announce the winner
    self:AnnounceWinner()

    print("Round finished")
end

function GameManager:AnnounceWinner()
    local players = Players:GetPlayers()
    if #players == 1 then
        local winner = players[1]
        Remotes.UpdateStatus:FireAllClients(winner.Name .. " is the winner!")
        print("Winner is " .. winner.Name)
    else
        Remotes.UpdateStatus:FireAllClients("It's a draw!")
        print("It's a draw!")
    end
end

function GameManager:TeleportPlayersToMap()
    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(Config.Map.SpawnPosition)
        end
    end
end

return GameManager
