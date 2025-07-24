-- EventRegistry: Registers all the events in the game.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Shared = ReplicatedStorage.Shared
local Events = require(Shared.Events)

local LavaRising = require(ServerScriptService.Server.Events.LavaRising)
local MeteorShower = require(ServerScriptService.Server.Events.MeteorShower)
local ShrinkingSafeZone = require(ServerScriptService.Server.Events.ShrinkingSafeZone)

Events:RegisterEvent(LavaRising)
Events:RegisterEvent(MeteorShower)
Events:RegisterEvent(ShrinkingSafeZone)
