-- LavaRising: An event where the lava rises, forcing players to climb higher.

local LavaRising = {}
LavaRising.Name = "Lava Rising"
LavaRising.Duration = 60 -- seconds

local LAVA_RISE_SPEED = 1

function LavaRising:Start()
    print(self.Name .. " event started!")

    -- Create the lava part
    self.Lava = Instance.new("Part")
    self.Lava.Name = "Lava"
    self.Lava.Size = Vector3.new(200, 1, 200)
    self.Lava.Position = Vector3.new(0, 10, 0)
    self.Lava.Anchored = true
    self.Lava.BrickColor = BrickColor.new("Really red")
    self.Lava.Material = Enum.Material.Neon
    self.Lava.Parent = workspace

    -- Connect the touch event
    self.Lava.Touched:Connect(function(otherPart)
        local character = otherPart.Parent
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end)

    -- Start the lava rising
    self.StartTime = tick()
end

function LavaRising:IsFinished()
    if not self.StartTime then
        return false
    end

    local elapsedTime = tick() - self.StartTime
    if elapsedTime >= self.Duration then
        -- Clean up the lava
        if self.Lava then
            self.Lava:Destroy()
        end
        return true
    end

    -- Move the lava up
    if self.Lava then
        local newY = 10 + elapsedTime * LAVA_RISE_SPEED
        self.Lava.Position = Vector3.new(0, newY, 0)
    end

    return false
end

return LavaRising
