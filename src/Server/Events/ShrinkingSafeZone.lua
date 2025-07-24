-- ShrinkingSafeZone: An event where the safe zone shrinks.

local ShrinkingSafeZone = {}
ShrinkingSafeZone.Name = "Shrinking Safe Zone"
ShrinkingSafeZone.Duration = 60 -- seconds

local DAMAGE_PER_SECOND = 10

function ShrinkingSafeZone:Start()
    print(self.Name .. " event started!")
    self.StartTime = tick()

    -- Create the safe zone visual
    self.SafeZonePart = Instance.new("Part")
    self.SafeZonePart.Name = "SafeZone"
    self.SafeZonePart.Shape = Enum.PartType.Cylinder
    self.SafeZonePart.Size = Vector3.new(1, 400, 400)
    self.SafeZonePart.Position = Vector3.new(0, 20, 0)
    self.SafeZonePart.Anchored = true
    self.SafeZonePart.BrickColor = BrickColor.new("Bright blue")
    self.SafeZonePart.Material = Enum.Material.ForceField
    self.SafeZonePart.Parent = workspace
end

function ShrinkingSafeZone:IsFinished()
    if not self.StartTime then
        return false
    end

    local elapsedTime = tick() - self.StartTime
    if elapsedTime >= self.Duration then
        if self.SafeZonePart then
            self.SafeZonePart:Destroy()
        end
        return true
    end

    -- Shrink the safe zone
    if self.SafeZonePart then
        local newSize = 400 - (elapsedTime / self.Duration) * 380 -- Shrinks from 400 to 20
        self.SafeZonePart.Size = Vector3.new(1, newSize, newSize)
    end

    -- Damage players outside the safe zone
    self:DamagePlayersOutsideZone()

    return false
end

function ShrinkingSafeZone:DamagePlayersOutsideZone()
    local players = game.Players:GetPlayers()
    for _, player in ipairs(players) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - self.SafeZonePart.Position).Magnitude
            if distance > self.SafeZonePart.Size.Y / 2 then
                player.Character.Humanoid:TakeDamage(DAMAGE_PER_SECOND / 60)
            end
        end
    end
end

return ShrinkingSafeZone
