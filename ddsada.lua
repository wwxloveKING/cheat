--[[
    SnapSanixHUB | MM2 / MMV FULL
    edited by wwxlove
]]

-- ==========================================================
--  SAFE BOOT
-- ==========================================================
repeat task.wait() until game:IsLoaded()
    and game.Players.LocalPlayer
    and game.Players.LocalPlayer:FindFirstChild("PlayerGui")

local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local Lighting   = game:GetService("Lighting")
local TweenSvc   = game:GetService("TweenService")
local LP         = Players.LocalPlayer
local Camera     = workspace.CurrentCamera

-- ГЛОБАЛЬНЫЙ ФЛАГ ВЫКЛЮЧЕНИЯ
local SNX_Closed = false
local SNX_Connections = {}
local function track(conn) table.insert(SNX_Connections, conn) return conn end
local function isAlive() return not SNX_Closed end

-- ==========================================================
--  INTRO
-- ==========================================================
local function safeIntro()
    pcall(function()
        local parent = (gethui and gethui()) or game:GetService("CoreGui")
        local sg = Instance.new("ScreenGui")
        sg.Name = "SNX_Intro"; sg.IgnoreGuiInset = true
        sg.ResetOnSpawn = false; sg.DisplayOrder = 9999
        local ok = pcall(function() sg.Parent = parent end)
        if not ok or not sg.Parent then sg.Parent = LP:FindFirstChild("PlayerGui") end

        local bg = Instance.new("Frame", sg)
        bg.Size = UDim2.new(1,0,1,0); bg.BackgroundColor3 = Color3.new(0,0,0)
        bg.BackgroundTransparency = 1; bg.BorderSizePixel = 0
        local grad = Instance.new("UIGradient", bg)
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(15,0,30)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5,0,15)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15,0,30)),
        })

        local title = Instance.new("TextLabel", bg)
        title.AnchorPoint = Vector2.new(0.5,0.5)
        title.Position = UDim2.new(0.5,0,0.5,-40)
        title.Size = UDim2.new(0,600,0,80)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBlack
        title.Text = "SnapSanixHUB"
        title.TextColor3 = Color3.fromRGB(255,255,255)
        title.TextSize = 60; title.TextTransparency = 1
        local tg = Instance.new("UIGradient", title)
        tg.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(180,0,255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,80,200)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255)),
        })

        local sub = Instance.new("TextLabel", bg)
        sub.AnchorPoint = Vector2.new(0.5,0.5)
        sub.Position = UDim2.new(0.5,0,0.5,30)
        sub.Size = UDim2.new(0,600,0,40)
        sub.BackgroundTransparency = 1
        sub.Font = Enum.Font.GothamBold
        sub.Text = "edited by wwxlove"
        sub.TextColor3 = Color3.fromRGB(200,120,255)
        sub.TextSize = 28; sub.TextTransparency = 1

        local line = Instance.new("Frame", bg)
        line.AnchorPoint = Vector2.new(0.5,0.5)
        line.Position = UDim2.new(0.5,0,0.5,80)
        line.Size = UDim2.new(0,0,0,2)
        line.BackgroundColor3 = Color3.fromRGB(180,80,255)
        line.BorderSizePixel = 0

        local bar = Instance.new("Frame", bg)
        bar.AnchorPoint = Vector2.new(0.5,0.5)
        bar.Position = UDim2.new(0.5,0,0.5,110)
        bar.Size = UDim2.new(0,400,0,4)
        bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
        bar.BorderSizePixel = 0
        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new(0,0,1,0)
        fill.BackgroundColor3 = Color3.fromRGB(180,80,255)
        fill.BorderSizePixel = 0

        local cred = Instance.new("TextLabel", bg)
        cred.AnchorPoint = Vector2.new(0.5,0.5)
        cred.Position = UDim2.new(0.5,0,1,-30)
        cred.Size = UDim2.new(0,600,0,20)
        cred.BackgroundTransparency = 1
        cred.Font = Enum.Font.Gotham
        cred.Text = "Murder Mystery 2 | MMV"
        cred.TextColor3 = Color3.fromRGB(140,140,140)
        cred.TextSize = 14; cred.TextTransparency = 1

        local function tw(o,t,p)
            TweenSvc:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p):Play()
        end
        tw(bg, 0.5, {BackgroundTransparency=0}); task.wait(0.4)
        title.Position = UDim2.new(0.5,0,0.5,-20)
        tw(title, 0.6, {TextTransparency=0, Position=UDim2.new(0.5,0,0.5,-40)}); task.wait(0.5)
        tw(sub, 0.4, {TextTransparency=0})
        tw(line, 0.5, {Size=UDim2.new(0,320,0,2)}); task.wait(0.3)
        tw(fill, 1.4, {Size=UDim2.new(1,0,1,0)}); task.wait(1.5)
        tw(cred, 0.4, {TextTransparency=0}); task.wait(1.2)
        tw(title,0.4,{TextTransparency=1}); tw(sub,0.4,{TextTransparency=1})
        tw(cred,0.4,{TextTransparency=1}); tw(line,0.4,{BackgroundTransparency=1})
        tw(bar,0.4,{BackgroundTransparency=1}); tw(fill,0.4,{BackgroundTransparency=1})
        tw(bg,0.5,{BackgroundTransparency=1}); task.wait(0.6)
        sg:Destroy()
    end)
end
safeIntro()

-- ==========================================================
--  LIBRARY
-- ==========================================================
local library
local ok, err = pcall(function()
    library = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Roman34296589/SnapSanixHUB/refs/heads/main/Library/R3TH"))()
end)
if not ok or not library then
    warn("[SnapSanixHUB] "..tostring(err)); return
end
local Venyx = library.new("SnapSanixHUB | wwxlove", 5013109572)

-- ==========================================================
--  STATE
-- ==========================================================
local S = {
    EspEnabled=false, ShowName=true, ShowRole=true, ShowDist=true,
    ShowTracer=false, ShowBox=false,
    MurdererColor=Color3.fromRGB(255,50,50),
    SheriffColor=Color3.fromRGB(50,140,255),
    InnocentColor=Color3.fromRGB(60,255,90),
    AutoShoot=false, AutoKnife=false, KillAura=false, KillAuraRange=8,
    FovCircle=false, AimFov=150,
    Speed=16, Jump=50, Noclip=false, InfJump=false, Fly=false, FlySpeed=50,
    Fullbright=false, AutoFarm=false, AntiAFK=true,
    HitboxEnabled=false, HitboxOnlyMurderer=false,
    HitboxInvisible=true, HitboxSize=12,
    StretchEnabled=false, StretchSize=5,
    TPSafeDistance=15,
    TPIgnoreMurderer=false,
}
local KB = {
    Shoot=Enum.KeyCode.E, Throw=Enum.KeyCode.Q,
    Fly=Enum.KeyCode.F, FlingMurderer=Enum.KeyCode.G,
    TPToPistol=Enum.KeyCode.T,
}

-- ==========================================================
--  HELPERS
-- ==========================================================
local function myHrp() local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart") end
local function myHum() local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid") end

local function getRole(plr)
    local char = plr.Character
    if not char then return "Innocent" end
    for _, cont in ipairs({char, plr:FindFirstChild("Backpack")}) do
        if cont then
            for _, t in ipairs(cont:GetChildren()) do
                if t:IsA("Tool") then
                    local n = t.Name:lower()
                    if n:find("knife") then return "Murderer" end
                    if n:find("gun") or n:find("revolver") then return "Sheriff" end
                end
            end
        end
    end
    return "Innocent"
end
local function roleColor(r)
    if r=="Murderer" then return S.MurdererColor end
    if r=="Sheriff"  then return S.SheriffColor  end
    return S.InnocentColor
end
local function findKnife()
    local c = LP.Character; if not c then return nil end
    for _, t in ipairs(c:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("knife") then return t end
    end
end

-- ==========================================================
--  ESP
-- ==========================================================
local EspData, Tracers = {}, {}
local function cleanup(plr)
    local d = EspData[plr]
    if d then
        for _, v in pairs(d) do
            if typeof(v)=="Instance" and v.Parent then v:Destroy() end
        end
        EspData[plr]=nil
    end
    local t = Tracers[plr]
    if t then pcall(function() t:Remove() end) Tracers[plr]=nil end
end
local function cleanupAll() for p in pairs(EspData) do cleanup(p) end end

local function makeEsp(plr)
    local char = plr.Character
    if not char or plr==LP then return end
    local head = char:FindFirstChild("Head")
    local hrp  = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid")
    if not head or not hrp or not hum or hum.Health<=0 then cleanup(plr) return end
    local d = EspData[plr]; if not d then d={} EspData[plr]=d end
    if not d.hl or d.hl.Parent~=char then
        if d.hl then d.hl:Destroy() end
        local hl = Instance.new("Highlight")
        hl.Name="SNX_HL"; hl.Adornee=char
        hl.FillTransparency=0.5; hl.OutlineTransparency=0
        hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent=char; d.hl=hl
    end
    if not d.bb or d.bb.Parent~=char then
        if d.bb then d.bb:Destroy() end
        local bb = Instance.new("BillboardGui")
        bb.Name="SNX_BB"; bb.Adornee=head
        bb.Size=UDim2.new(0,220,0,60)
        bb.StudsOffset=Vector3.new(0,2.5,0)
        bb.AlwaysOnTop=true; bb.Parent=char
        local lb = Instance.new("TextLabel")
        lb.Name="SNX_LB"; lb.BackgroundTransparency=1
        lb.Size=UDim2.new(1,0,1,0)
        lb.Font=Enum.Font.GothamBold; lb.TextSize=14
        lb.TextStrokeTransparency=0.3
        lb.TextStrokeColor3=Color3.new(0,0,0)
        lb.Parent=bb; d.bb=bb; d.label=lb
    end
    if S.ShowBox then
        if not d.box or d.box.Parent~=char then
            if d.box then d.box:Destroy() end
            local box = Instance.new("BoxHandleAdornment")
            box.Name="SNX_Box"; box.Adornee=hrp
            box.Size=Vector3.new(3,6,2)
            box.AlwaysOnTop=true; box.ZIndex=5
            box.Transparency=0.6
            box.Parent=char; d.box=box
        end
    elseif d.box then
        d.box:Destroy(); d.box=nil
    end
end

local function renderEsp()
    if SNX_Closed then return end
    if not S.EspEnabled then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr~=LP then
            pcall(makeEsp, plr)
            local d = EspData[plr]
            if d then
                local role = S.ShowRole and getRole(plr) or "Innocent"
                local color = roleColor(role)
                if d.hl then d.hl.FillColor=color; d.hl.OutlineColor=color end
                if d.box then d.box.Color3=color end
                local txt = ""
                if S.ShowName then txt = plr.Name end
                if S.ShowRole then txt = txt.." ["..role.."]" end
                if S.ShowDist then
                    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if h then txt = txt.." | "..math.floor((Camera.CFrame.Position-h.Position).Magnitude).."m" end
                end
                if d.label then d.label.Text=txt; d.label.TextColor3=color end
                if S.ShowTracer then
                    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if h then
                        pcall(function()
                            local t = Tracers[plr]
                            if not t then t=Drawing.new("Line") Tracers[plr]=t end
                            t.From=Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            local sp, vis = Camera:WorldToViewportPoint(h.Position)
                            t.To=Vector2.new(sp.X, sp.Y)
                            t.Color=color; t.Thickness=1; t.Transparency=0.7
                            t.Visible=vis
                        end)
                    end
                end
            end
        end
    end
end
track(Players.PlayerRemoving:Connect(function(p) pcall(cleanup, p) end))
track(RunService.RenderStepped:Connect(function() pcall(renderEsp) end))

-- ==========================================================
--  BIG HITBOX
-- ==========================================================
local HitboxParts = {}
local function makeHitbox(plr)
    if plr == LP then return end
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then
        if HitboxParts[plr] then HitboxParts[plr]:Destroy() HitboxParts[plr]=nil end
        return
    end
    if S.HitboxOnlyMurderer and getRole(plr) ~= "Murderer" then
        if HitboxParts[plr] then HitboxParts[plr]:Destroy() HitboxParts[plr]=nil end
        return
    end
    local part = HitboxParts[plr]
    if not part or part.Parent ~= char then
        if part then part:Destroy() end
        part = Instance.new("Part")
        part.Name = "SNX_Hitbox"
        part.Shape = Enum.PartType.Ball
        part.Material = Enum.Material.ForceField
        part.CanCollide = false
        part.CanQuery = true
        part.CanTouch = true
        part.Massless = true
        part.Anchored = false
        part.Transparency = S.HitboxInvisible and 1 or 0.5
        part.Color = roleColor(getRole(plr))
        part.Size = Vector3.new(S.HitboxSize, S.HitboxSize, S.HitboxSize)
        part.CFrame = hrp.CFrame
        part.Parent = char
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = part; weld.Part1 = hrp; weld.Parent = part
        HitboxParts[plr] = part
    else
        part.Size = Vector3.new(S.HitboxSize, S.HitboxSize, S.HitboxSize)
        part.Transparency = S.HitboxInvisible and 1 or 0.5
        part.Color = roleColor(getRole(plr))
    end
end

local function clearHitboxes()
    for plr, part in pairs(HitboxParts) do
        if part and part.Parent then part:Destroy() end
    end
    HitboxParts = {}
end

local function updateHitboxes()
    if SNX_Closed then return end
    if not S.HitboxEnabled then
        if next(HitboxParts) then clearHitboxes() end
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then pcall(makeHitbox, plr) end
    end
end

track(RunService.Heartbeat:Connect(function() pcall(updateHitboxes) end))
track(Players.PlayerRemoving:Connect(function(p)
    if HitboxParts[p] then HitboxParts[p]:Destroy() HitboxParts[p]=nil end
end))

-- ==========================================================
--  STRETCH
-- ==========================================================
local OrigSizes = {}

local function applyStretch()
    local char = LP.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and not OrigSizes[p] then OrigSizes[p] = p.Size end
    end
    pcall(function()
        local orig = OrigSizes[hrp] or Vector3.new(2, 2, 1)
        hrp.Size = Vector3.new(orig.X * S.StretchSize, orig.Y, orig.Z * S.StretchSize)
    end)
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" and p.Name ~= "Head" then
            local orig = OrigSizes[p]
            if orig then
                pcall(function()
                    p.Size = Vector3.new(orig.X * 2, orig.Y, orig.Z * 2)
                end)
            end
        end
    end
end

local function resetStretch()
    for p, orig in pairs(OrigSizes) do
        pcall(function()
            if p and p.Parent then p.Size = orig end
        end)
    end
    OrigSizes = {}
end

task.spawn(function()
    while isAlive() do
        task.wait(0.5)
        if S.StretchEnabled then pcall(applyStretch) end
    end
end)

-- ==========================================================
--  TP TO PISTOL (улучшенный)
-- ==========================================================
local function isGunName(n)
    n = n:lower()
    return n:find("gun") or n:find("revolver") or n:find("pistol")
end

local function findAllGuns()
    local found = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("Tool") or obj:IsA("Model")) and isGunName(obj.Name) then
            table.insert(found, obj)
        end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            if char then
                for _, t in ipairs(char:GetChildren()) do
                    if t:IsA("Tool") and isGunName(t.Name) then
                        table.insert(found, t)
                    end
                end
            end
            local bp = plr:FindFirstChild("Backpack")
            if bp then
                for _, t in ipairs(bp:GetChildren()) do
                    if t:IsA("Tool") and isGunName(t.Name) then
                        table.insert(found, t)
                    end
                end
            end
        end
    end
    return found
end

local function getObjectPosition(obj)
    if not obj or not obj.Parent then return nil end
    if obj:IsA("Tool") then
        local handle = obj:FindFirstChild("Handle")
        if handle then return handle.Position end
        if obj.Parent and obj.Parent:IsA("BasePart") then return obj.Parent.Position end
    elseif obj:IsA("Model") then
        local pp = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
        if pp then return pp.Position end
    elseif obj:IsA("BasePart") then
        return obj.Position
    end
    return nil
end

local function nearestMurdererDistance(targetPos)
    local md = math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and getRole(plr) == "Murderer" then
            local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if h then
                local d = (h.Position - targetPos).Magnitude
                if d < md then md = d end
            end
        end
    end
    return md
end

local function tpToPistol()
    if SNX_Closed then return false end
    local guns = findAllGuns()
    if #guns == 0 then
        pcall(function() Venyx:Notify("TP", "Пушка не найдена (0)") end)
        return false
    end

    local myH = myHrp(); if not myH then return false end

    local bestGun, bestPos, bestDist = nil, nil, math.huge
    for _, g in ipairs(guns) do
        local pos = getObjectPosition(g)
        if pos then
            local d = (pos - myH.Position).Magnitude
            if d < bestDist then
                bestGun, bestPos, bestDist = g, pos, d
            end
        end
    end

    if not bestPos then
        pcall(function() Venyx:Notify("TP", "Позиция не найдена ("..#guns..")") end)
        return false
    end

    local md = nearestMurdererDistance(bestPos)
    if not S.TPIgnoreMurderer and md <= S.TPSafeDistance then
        pcall(function()
            Venyx:Notify("TP", "ОТКАЗ: мардер "..math.floor(md).."m < "..S.TPSafeDistance.."m")
        end)
        return false
    end

    local okTP = pcall(function()
        myH.CFrame = CFrame.new(bestPos + Vector3.new(0, 3, 0))
        myH.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end)

    if okTP then
        pcall(function()
            Venyx:Notify("TP", "OK -> "..bestGun.Name.." | мардер "..math.floor(md).."m")
        end)
        return true
    else
        pcall(function() Venyx:Notify("TP", "Ошибка ТП") end)
        return false
    end
end

local function tpToSheriff()
    if SNX_Closed then return false end
    local myH = myHrp(); if not myH then return false end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and getRole(plr) == "Sheriff" then
            local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if h then
                pcall(function() myH.CFrame = h.CFrame + Vector3.new(0, 3, 0) end)
                pcall(function() Venyx:Notify("TP", "-> Sheriff "..plr.Name) end)
                return true
            end
        end
    end
    pcall(function() Venyx:Notify("TP", "Sheriff не найден") end)
    return false
end

-- ==========================================================
--  AIMBOT
-- ==========================================================
local function nearestMurderer()
    local hrp = myHrp(); if not hrp then return nil end
    local best, bd = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr~=LP then
            local c = plr.Character
            local h = c and c:FindFirstChild("HumanoidRootPart")
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if h and hum and hum.Health>0 and getRole(plr)=="Murderer" then
                local d = (h.Position-hrp.Position).Magnitude
                if d<bd then best, bd = h, d end
            end
        end
    end
    return best
end
local function shootAt(target)
    if SNX_Closed then return end
    pcall(function()
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        if mouse1click then mouse1click()
        elseif VirtualUser then
            VirtualUser:Button1Down(Vector2.new(0,0), Camera.CFrame)
            task.wait(0.02)
            VirtualUser:Button1Up(Vector2.new(0,0), Camera.CFrame)
        end
    end)
end
local function throwKnife()
    if SNX_Closed then return end
    local knife = findKnife(); if not knife then return end
    local t = nearestMurderer()
    pcall(function()
        if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Position) end
        knife:Activate()
        if knife:FindFirstChild("Handle") and firetouchinterest then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr~=LP then
                    local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if h then
                        firetouchinterest(knife.Handle, h, 0)
                        task.wait(0.01)
                        firetouchinterest(knife.Handle, h, 1)
                    end
                end
            end
        end
    end)
end

local FovC
pcall(function()
    FovC = Drawing.new("Circle")
    FovC.Visible=false; FovC.Thickness=1; FovC.NumSides=64
    FovC.Filled=false; FovC.Transparency=0.8
    FovC.Color=Color3.fromRGB(180,80,255)
end)
track(RunService.RenderStepped:Connect(function()
    if SNX_Closed then
        if FovC then pcall(function() FovC.Visible = false end) end
        return
    end
    if FovC then
        pcall(function()
            FovC.Visible = S.FovCircle
            if S.FovCircle then
                FovC.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                FovC.Radius = S.AimFov
            end
        end)
    end
end))

task.spawn(function()
    while isAlive() do
        task.wait(0.05)
        if S.AutoShoot and getRole(LP)=="Sheriff" then
            local t = nearestMurderer(); if t then shootAt(t) end
        end
    end
end)
task.spawn(function()
    while isAlive() do
        task.wait(0.15)
        if S.AutoKnife and getRole(LP)=="Murderer" then
            local hrp = myHrp()
            if hrp then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr~=LP then
                        local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                        if h and (h.Position-hrp.Position).Magnitude<8 then
                            local k = findKnife()
                            if k then pcall(function()
                                k:Activate()
                                if firetouchinterest then
                                    firetouchinterest(k.Handle, h, 0)
                                    firetouchinterest(k.Handle, h, 1)
                                end
                            end) end
                        end
                    end
                end
            end
        end
    end
end)
task.spawn(function()
    while isAlive() do
        task.wait(0.15)
        if S.KillAura then
            local hrp = myHrp()
            if hrp then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr~=LP then
                        local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                        if h and (h.Position-hrp.Position).Magnitude<=S.KillAuraRange then
                            local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
                            if tool then pcall(function()
                                tool:Activate()
                                if firetouchinterest and tool:FindFirstChild("Handle") then
                                    firetouchinterest(tool.Handle, h, 0)
                                    firetouchinterest(tool.Handle, h, 1)
                                end
                            end) end
                        end
                    end
                end
            end
        end
    end
end)

-- ==========================================================
--  FLING v2
-- ==========================================================
local FlingThread = nil
local FlingTarget = nil

local function getTargetsByRole(role)
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if getRole(plr) == role then table.insert(list, plr) end
        end
    end
    return list
end
local function getAllTargets()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(list, plr)
        end
    end
    return list
end

local function flingPlayer(target)
    if SNX_Closed then return end
    local char = target.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    local myH = myHrp(); local myHum_ = myHum()
    if not myH or not myHum_ then return end
    pcall(function()
        myH.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 1.5, 0))
            * CFrame.Angles(math.random()*6, math.random()*6, math.random()*6)
    end)
    local weld
    pcall(function()
        weld = Instance.new("WeldConstraint")
        weld.Part0 = myH; weld.Part1 = hrp; weld.Parent = myH
    end)
    pcall(function()
        myH.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
        myH.AssemblyLinearVelocity = Vector3.new(
            math.random(-500, 500), math.random(500, 2000), math.random(-500, 500))
    end)
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then
            pcall(function()
                p.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
                p.AssemblyLinearVelocity = Vector3.new(0, 500, 0)
            end)
        end
    end
    task.delay(0.25, function()
        if weld then pcall(function() weld:Destroy() end) end
        if myH then
            pcall(function()
                myH.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                myH.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end)
        end
    end)
end

local function startFling(mode)
    if SNX_Closed then return end
    FlingTarget = mode
    if FlingThread then pcall(function() task.cancel(FlingThread) end) end
    FlingThread = task.spawn(function()
        while FlingTarget and isAlive() do
            local targets
            if FlingTarget == "Murderer" then targets = getTargetsByRole("Murderer")
            elseif FlingTarget == "Sheriff" then targets = getTargetsByRole("Sheriff")
            elseif FlingTarget == "All" then targets = getAllTargets()
            elseif typeof(FlingTarget) == "Instance" then
                targets = FlingTarget.Character and {FlingTarget} or {}
            else targets = {} end
            for _, plr in ipairs(targets) do pcall(flingPlayer, plr) end
            task.wait(0.35)
        end
    end)
end
local function stopFling()
    FlingTarget = nil
    if FlingThread then
        pcall(function() task.cancel(FlingThread) end)
        FlingThread = nil
    end
end

-- ==========================================================
--  KEYBINDS
-- ==========================================================
local HoldingShoot, HoldingThrow = false, false
track(UIS.InputBegan:Connect(function(input, gpe)
    if SNX_Closed or gpe then return end
    local k = input.KeyCode
    if k==KB.Shoot then HoldingShoot=true end
    if k==KB.Throw then HoldingThrow=true end
    if k==KB.Fly then S.Fly = not S.Fly end
    if k==KB.FlingMurderer then
        if FlingTarget=="Murderer" then stopFling()
        else startFling("Murderer") end
    end
    if k==KB.TPToPistol then pcall(tpToPistol) end
end))
track(UIS.InputEnded:Connect(function(input)
    if SNX_Closed then return end
    local k = input.KeyCode
    if k==KB.Shoot then HoldingShoot=false end
    if k==KB.Throw then HoldingThrow=false end
end))
task.spawn(function()
    while isAlive() do
        task.wait(0.05)
        if HoldingShoot and getRole(LP)=="Sheriff" then
            local t = nearestMurderer(); if t then shootAt(t) end
        end
    end
end)
task.spawn(function()
    while isAlive() do
        task.wait(0.15)
        if HoldingThrow and getRole(LP)=="Murderer" then throwKnife() end
    end
end)

-- ==========================================================
--  MOVEMENT
-- ==========================================================
task.spawn(function()
    while isAlive() do
        task.wait(0.1)
        local hum = myHum()
        if hum then
            if S.Speed~=16 then hum.WalkSpeed=S.Speed end
            if S.Jump~=50 then hum.UseJumpPower=true hum.JumpPower=S.Jump end
        end
    end
end)
task.spawn(function()
    while isAlive() do
        task.wait()
        if S.Noclip then
            local c = LP.Character
            if c then
                for _, p in ipairs(c:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide=false end
                end
            end
        end
    end
end)
track(UIS.JumpRequest:Connect(function()
    if SNX_Closed then return end
    if S.InfJump then
        local hum = myHum(); if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

local flyBV, flyBG
task.spawn(function()
    while isAlive() do
        task.wait()
        if S.Fly then
            local hrp, hum = myHrp(), myHum()
            if hrp and hum and not flyBV then
                hum.PlatformStand = true
                flyBV = Instance.new("BodyVelocity", hrp)
                flyBV.MaxForce = Vector3.new(9e9,9e9,9e9)
                flyBV.Velocity = Vector3.new(0,0,0)
                flyBG = Instance.new("BodyGyro", hrp)
                flyBG.MaxTorque = Vector3.new(9e9,9e9,9e9)
                flyBG.P = 1000
                flyBG.CFrame = hrp.CFrame
            end
            if hrp and flyBV then
                local dir = Vector3.new(0,0,0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
                flyBV.Velocity = dir * S.FlySpeed
                flyBG.CFrame = Camera.CFrame
            end
        else
            if flyBV then flyBV:Destroy() flyBV=nil end
            if flyBG then flyBG:Destroy() flyBG=nil end
            local hum = myHum(); if hum then hum.PlatformStand=false end
        end
    end
end)

local OldLight = {
    Brightness=Lighting.Brightness, Ambient=Lighting.Ambient,
    OutdoorAmbient=Lighting.OutdoorAmbient, FogEnd=Lighting.FogEnd,
    ClockTime=Lighting.ClockTime,
}
task.spawn(function()
    while isAlive() do
        task.wait(1)
        if S.Fullbright then
            Lighting.Brightness=2
            Lighting.Ambient=Color3.fromRGB(180,180,180)
            Lighting.OutdoorAmbient=Color3.fromRGB(180,180,180)
            Lighting.FogEnd=1e6
            Lighting.ClockTime=14
        else
            Lighting.Brightness=OldLight.Brightness
            Lighting.Ambient=OldLight.Ambient
            Lighting.OutdoorAmbient=OldLight.OutdoorAmbient
            Lighting.FogEnd=OldLight.FogEnd
            Lighting.ClockTime=OldLight.ClockTime
        end
    end
end)

-- ==========================================================
--  SKY
-- ==========================================================
local SkyPresets = {
    Default={}, Sunset={Top=Color3.fromRGB(255,130,80),Bottom=Color3.fromRGB(255,200,100)},
    Night={Top=Color3.fromRGB(5,5,30),Bottom=Color3.fromRGB(15,15,50)},
    Space={Top=Color3.fromRGB(0,0,0),Bottom=Color3.fromRGB(10,10,40)},
    Purple={Top=Color3.fromRGB(80,0,130),Bottom=Color3.fromRGB(200,100,255)},
    Galaxy={Top=Color3.fromRGB(20,0,60),Bottom=Color3.fromRGB(120,40,200)},
    Red={Top=Color3.fromRGB(120,0,0),Bottom=Color3.fromRGB(255,60,60)},
    Nebula={Top=Color3.fromRGB(0,40,80),Bottom=Color3.fromRGB(180,100,220)},
}
local SkyList = {}
for k in pairs(SkyPresets) do table.insert(SkyList, k) end
table.sort(SkyList)

local SkyObj, AtmoObj
local HiddenSkies = {}
local function hideOriginalSkies()
    for _, cont in ipairs({Lighting, workspace, workspace:FindFirstChild("Terrain")}) do
        if cont then
            for _, obj in ipairs(cont:GetChildren()) do
                if obj:IsA("Sky") and obj.Name ~= "SNX_Sky" then
                    table.insert(HiddenSkies, {obj=obj, parent=cont})
                    obj.Parent = nil
                end
            end
        end
    end
end
local function restoreOriginalSkies()
    for _, entry in ipairs(HiddenSkies) do
        pcall(function()
            if entry.obj and entry.parent then entry.obj.Parent = entry.parent end
        end)
    end
    HiddenSkies = {}
end
local function setSky(name)
    if SkyObj then pcall(function() SkyObj:Destroy() end) SkyObj=nil end
    if AtmoObj then pcall(function() AtmoObj:Destroy() end) AtmoObj=nil end
    if name == "Default" then restoreOriginalSkies(); return end
    local preset = SkyPresets[name]; if not preset then return end
    hideOriginalSkies()
    local sky = Instance.new("Sky")
    sky.Name="SNX_Sky"
    sky.SkyboxBk="rbxassetid://159454299"
    sky.SkyboxDn="rbxassetid://159454296"
    sky.SkyboxFt="rbxassetid://159454293"
    sky.SkyboxLf="rbxassetid://159454286"
    sky.SkyboxRt="rbxassetid://159454300"
    sky.SkyboxUp="rbxassetid://159454288"
    sky.Parent=Lighting; SkyObj=sky
    local atmo = Instance.new("Atmosphere")
    atmo.Name="SNX_Atmo"
    atmo.Color=preset.Bottom or Color3.new(0,0,0)
    atmo.Decay=preset.Top or Color3.new(0,0,0)
    atmo.Density=0.4; atmo.Glare=0.3; atmo.Haze=2
    atmo.Parent=Lighting; AtmoObj=atmo
    Lighting.FogEnd=1e6
    Lighting.OutdoorAmbient = preset.Bottom or Color3.new(0.4,0.4,0.4)
    task.spawn(function()
        Lighting.FogEnd=100
        task.wait(0.05)
        Lighting.FogEnd=1e6
    end)
end

-- ==========================================================
--  CURSOR
-- ==========================================================
local CursorGui, CursorImg
pcall(function()
    local parent = (gethui and gethui()) or game:GetService("CoreGui")
    CursorGui = Instance.new("ScreenGui")
    CursorGui.Name = "SNX_Dot"
    CursorGui.IgnoreGuiInset = true
    CursorGui.ResetOnSpawn = false
    CursorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    CursorGui.DisplayOrder = 100000
    CursorGui.Parent = parent
end)
if not CursorGui then
    CursorGui = Instance.new("ScreenGui")
    CursorGui.Name = "SNX_Dot"
    CursorGui.IgnoreGuiInset = true
    CursorGui.ResetOnSpawn = false
    CursorGui.Parent = LP:WaitForChild("PlayerGui")
end
CursorImg = Instance.new("Frame")
CursorImg.Name = "Dot"
CursorImg.BackgroundColor3 = Color3.fromRGB(255, 80, 220)
CursorImg.BorderSizePixel = 0
CursorImg.Size = UDim2.new(0, 10, 0, 10)
CursorImg.AnchorPoint = Vector2.new(0.5, 0.5)
CursorImg.ZIndex = 100000
CursorImg.Parent = CursorGui
local dotCorner = Instance.new("UICorner", CursorImg)
dotCorner.CornerRadius = UDim.new(1, 0)
local dotStroke = Instance.new("UIStroke", CursorImg)
dotStroke.Color = Color3.fromRGB(255,255,255)
dotStroke.Thickness = 1.5
UIS.MouseIconEnabled = false
track(RunService.RenderStepped:Connect(function()
    if SNX_Closed then return end
    local m = UIS:GetMouseLocation()
    CursorImg.Position = UDim2.new(0, m.X, 0, m.Y)
end))

-- ==========================================================
--  AUTO FARM / ANTI-AFK
-- ==========================================================
local function getPlayButton()
    local pg = LP:FindFirstChild("PlayerGui"); if not pg then return nil end
    for _, o in ipairs(pg:GetDescendants()) do
        if o:IsA("TextButton") or o:IsA("ImageButton") then
            local txt = o.Text
            if o:FindFirstChildOfClass("TextLabel") then
                txt = txt ~= "" and txt or o:FindFirstChildOfClass("TextLabel").Text
            end
            if txt and txt:lower():find("play") then return o end
        end
    end
    return nil
end
task.spawn(function()
    while isAlive() do
        task.wait(1)
        if S.AutoFarm then
            local btn = getPlayButton()
            if btn then pcall(function()
                if firesignal then firesignal(btn.MouseButton1Click) end
                btn:Activate()
            end) end
        end
    end
end)
task.spawn(function()
    while isAlive() do
        task.wait(60)
        if S.AntiAFK and VirtualUser then pcall(function() VirtualUser:CaptureController() end) end
    end
end)

-- ==========================================================
--  UI
-- ==========================================================
local MainPage   = Venyx:addPage("Main", 5012544693)
local VisualPage = Venyx:addPage("Visuals", 5012544693)
local CombatPage = Venyx:addPage("Combat", 5012544693)
local FlingPage  = Venyx:addPage("Fling", 5012544693)
local TPPage     = Venyx:addPage("ТП", 5012544693)
local MovePage   = Venyx:addPage("Movement", 5012544693)
local MiscPage   = Venyx:addPage("Misc", 5012544693)
local BindPage   = Venyx:addPage("Keybinds", 5012544693)
local ThemePage  = Venyx:addPage("Theme", 5012544693)

MainPage:addSection("Info"):addParagraph("SnapSanixHUB", "edited by wwxlove")
MainPage:addSection("Info"):addParagraph("Build", "MM2 / MMV full")
local ActSec = MainPage:addSection("Actions")
ActSec:addButton("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)
ActSec:addButton("Server Hop", function()
    pcall(function()
        local TS = game:GetService("TeleportService")
        local Http = game:GetService("HttpService")
        local data = Http:JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"))
        for _, srv in ipairs(data.data) do
            if srv.id ~= game.JobId and srv.playing < srv.maxPlayers then
                TS:TeleportToPlaceInstance(game.PlaceId, srv.id, LP); break
            end
        end
    end)
end)

local EspSec = VisualPage:addSection("ESP")
EspSec:addToggle("Enable ESP", false, function(v) S.EspEnabled=v if not v then cleanupAll() end end)
EspSec:addToggle("Show Names", true, function(v) S.ShowName=v end)
EspSec:addToggle("Show Roles", true, function(v) S.ShowRole=v end)
EspSec:addToggle("Show Distance", true, function(v) S.ShowDist=v end)
EspSec:addToggle("Show Box", false, function(v) S.ShowBox=v end)
EspSec:addToggle("Show Tracers", false, function(v) S.ShowTracer=v end)
local EspCol = VisualPage:addSection("ESP Colors")
EspCol:addColorPicker("Murderer", S.MurdererColor, function(c) S.MurdererColor=c end)
EspCol:addColorPicker("Sheriff",  S.SheriffColor,  function(c) S.SheriffColor=c end)
EspCol:addColorPicker("Innocent", S.InnocentColor, function(c) S.InnocentColor=c end)

local ShootSec = CombatPage:addSection("Shoot")
ShootSec:addToggle("Auto Shoot (Sheriff)", false, function(v) S.AutoShoot=v end)
ShootSec:addToggle("FOV Circle", false, function(v) S.FovCircle=v end)
ShootSec:addSlider("FOV Size", 150, 20, 800, function(v) S.AimFov=v end)
local KnifeSec = CombatPage:addSection("Knife")
KnifeSec:addToggle("Auto Knife (Murderer)", false, function(v) S.AutoKnife=v end)
KnifeSec:addToggle("Kill Aura", false, function(v) S.KillAura=v end)
KnifeSec:addSlider("Kill Aura Range", 8, 3, 30, function(v) S.KillAuraRange=v end)

local HitboxSec = CombatPage:addSection("Big Hitbox")
HitboxSec:addToggle("Enable Big Hitbox", false, function(v) S.HitboxEnabled=v if not v then clearHitboxes() end end)
HitboxSec:addToggle("Only Murderer", false, function(v) S.HitboxOnlyMurderer=v end)
HitboxSec:addToggle("Invisible Hitbox", true, function(v) S.HitboxInvisible=v end)
HitboxSec:addSlider("Hitbox Size", 12, 4, 40, function(v) S.HitboxSize=v end)

local StretchSec = CombatPage:addSection("Stretch (растяг)")
StretchSec:addToggle("Enable Stretch", false, function(v)
    S.StretchEnabled = v
    if not v then resetStretch() end
end)
StretchSec:addSlider("Stretch Size", 5, 2, 20, function(v)
    S.StretchSize = v
    if S.StretchEnabled then pcall(applyStretch) end
end)

local FlingRoleSec = FlingPage:addSection("Fling by Role")
FlingRoleSec:addButton("Fling Murderer", function() startFling("Murderer") Venyx:Notify("Fling","Murderer") end)
FlingRoleSec:addButton("Fling Sheriff", function() startFling("Sheriff") Venyx:Notify("Fling","Sheriff") end)
FlingRoleSec:addButton("Fling All Players", function() startFling("All") Venyx:Notify("Fling","All") end)
FlingRoleSec:addButton("Stop Fling", function() stopFling() Venyx:Notify("Fling","Stopped") end)
local FlingNameSec = FlingPage:addSection("Fling by Name")
FlingNameSec:addTextbox("Player Name", "", function(text, focusLost)
    if focusLost and text~="" then
        local plr = Players:FindFirstChild(text)
        if plr then startFling(plr) Venyx:Notify("Fling", plr.Name)
        else Venyx:Notify("Fling", "not found") end
    end
end)
FlingNameSec:addButton("Stop Fling", function() stopFling() end)

-- TP page (обновлённая)
local TPSec = TPPage:addSection("К пушке")
TPSec:addButton("TP to Pistol (safe)", function() tpToPistol() end)
TPSec:addButton("TP to Sheriff", function() tpToSheriff() end)
TPSec:addToggle("Ignore Murderer", false, function(v) S.TPIgnoreMurderer = v end)
TPSec:addSlider("Safe Distance", 15, 5, 100, function(v) S.TPSafeDistance = v end)
TPSec:addParagraph("Info", "Если мардер ближе Safe Distance — ТП отменится. Включи Ignore Murderer чтобы отключить проверку.")
local TPPlySec = TPPage:addSection("К игроку")
TPPlySec:addTextbox("Player Name", "", function(text, focusLost)
    if focusLost and text~="" then
        local plr = Players:FindFirstChild(text)
        local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        local myH = myHrp()
        if hrp and myH then myH.CFrame = hrp.CFrame + Vector3.new(0,3,0) end
    end
end)
TPPlySec:addButton("Bring All to Me", function()
    local myH = myHrp(); if not myH then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr~=LP then
            local h = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if h then h.CFrame = myH.CFrame + Vector3.new(3,0,0) end
        end
    end
end)

local MoveSec = MovePage:addSection("Character")
MoveSec:addSlider("WalkSpeed", 16, 16, 200, function(v) S.Speed=v end)
MoveSec:addSlider("JumpPower", 50, 50, 300, function(v) S.Jump=v end)
MoveSec:addToggle("Noclip", false, function(v) S.Noclip=v end)
MoveSec:addToggle("Infinite Jump", false, function(v) S.InfJump=v end)
MoveSec:addToggle("Fly", false, function(v) S.Fly=v end)
MoveSec:addSlider("Fly Speed", 50, 10, 300, function(v) S.FlySpeed=v end)

local MiscSec = MiscPage:addSection("World")
MiscSec:addToggle("Fullbright", false, function(v) S.Fullbright=v end)
MiscSec:addDropdown("Sky", SkyList, function(v) setSky(v) end)
local CurSec = MiscPage:addSection("Cursor")
CurSec:addColorPicker("Dot Color", Color3.fromRGB(255,80,220), function(c)
    CursorImg.BackgroundColor3 = c
end)
local FarmSec = MiscPage:addSection("Farm")
FarmSec:addToggle("Auto Farm Coins", false, function(v) S.AutoFarm=v end)
FarmSec:addToggle("Anti AFK", true, function(v) S.AntiAFK=v end)

local BindSec = BindPage:addSection("Hold")
BindSec:addKeybind("Shoot at Murderer", KB.Shoot, function() end, function(key, update)
    if key and key.KeyCode then KB.Shoot = key.KeyCode update(key.KeyCode) end
end)
BindSec:addKeybind("Throw Knife", KB.Throw, function() end, function(key, update)
    if key and key.KeyCode then KB.Throw = key.KeyCode update(key.KeyCode) end
end)
local PressSec = BindPage:addSection("Press")
PressSec:addKeybind("Toggle Fly", KB.Fly, function()
    S.Fly = not S.Fly
    Venyx:Notify("Fly", S.Fly and "ON" or "OFF")
end, function(key, update)
    if key and key.KeyCode then KB.Fly = key.KeyCode update(key.KeyCode) end
end)
PressSec:addKeybind("Fling Murderer", KB.FlingMurderer, function()
    if FlingTarget=="Murderer" then stopFling() Venyx:Notify("Fling","OFF")
    else startFling("Murderer") Venyx:Notify("Fling","ON - Murderer") end
end, function(key, update)
    if key and key.KeyCode then KB.FlingMurderer = key.KeyCode update(key.KeyCode) end
end)
PressSec:addKeybind("TP to Pistol", KB.TPToPistol, function()
    pcall(tpToPistol)
end, function(key, update)
    if key and key.KeyCode then KB.TPToPistol = key.KeyCode update(key.KeyCode) end
end)

local ThemeSec = ThemePage:addSection("Theme")
for name, color in pairs({
    Background=Color3.fromRGB(24,24,24), Glow=Color3.fromRGB(0,0,0),
    Accent=Color3.fromRGB(10,10,10), LightContrast=Color3.fromRGB(20,20,20),
    DarkContrast=Color3.fromRGB(14,14,14), TextColor=Color3.fromRGB(255,255,255),
}) do
    ThemeSec:addColorPicker(name, color, function(c) Venyx:setTheme(name, c) end)
end

MainPage:addSection("UI"):addKeybind("Toggle UI", Enum.KeyCode.RightControl, function()
    Venyx:toggle()
end, function() end)

if Venyx.pages and Venyx.pages[1] then
    Venyx:SelectPage(Venyx.pages[1], true)
end

-- ==========================================================
--  PANIC BUTTON
-- ==========================================================
local panicParent = (gethui and gethui()) or game:GetService("CoreGui")
local PanicGui = Instance.new("ScreenGui")
PanicGui.Name = "SNX_Panic"
PanicGui.IgnoreGuiInset = true
PanicGui.ResetOnSpawn = false
PanicGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PanicGui.DisplayOrder = 50000
pcall(function() PanicGui.Parent = panicParent end)
if not PanicGui.Parent then PanicGui.Parent = LP:WaitForChild("PlayerGui") end

local PanicSquare = Instance.new("ImageButton")
PanicSquare.Name = "CatSquare"
PanicSquare.Size = UDim2.new(0, 50, 0, 50)
PanicSquare.Position = UDim2.new(0, 10, 0, 10)
PanicSquare.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PanicSquare.BorderSizePixel = 0
PanicSquare.AutoButtonColor = false
PanicSquare.Image = "rbxassetid://83316446758674"
PanicSquare.ImageTransparency = 0
PanicSquare.ScaleType = Enum.ScaleType.Crop
PanicSquare.ZIndex = 50000
PanicSquare.Parent = PanicGui

local panicCorner = Instance.new("UICorner", PanicSquare)
panicCorner.CornerRadius = UDim.new(0, 8)
local panicStroke = Instance.new("UIStroke", PanicSquare)
panicStroke.Color = Color3.fromRGB(180, 80, 255)
panicStroke.Thickness = 1.5

task.delay(2, function()
    if SNX_Closed then return end
    if PanicSquare.ImageTransparency > 0 or PanicSquare.Image == "" then
        if not PanicSquare:FindFirstChild("CatEmoji") then
            local e = Instance.new("TextLabel")
            e.Name = "CatEmoji"
            e.Size = UDim2.new(1, 0, 1, 0)
            e.BackgroundTransparency = 1
            e.Font = Enum.Font.GothamBold
            e.Text = "🐱"
            e.TextScaled = true
            e.ZIndex = 50001
            e.Parent = PanicSquare
        end
    end
end)

do
    local dragging, dragStart, startPos
    PanicSquare.InputBegan:Connect(function(input)
        if SNX_Closed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = PanicSquare.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    PanicSquare.InputChanged:Connect(function(input)
        if SNX_Closed then return end
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            PanicSquare.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local uiHidden = false
local lastClick = 0
PanicSquare.MouseButton1Click:Connect(function()
    if SNX_Closed then return end
    if tick() - lastClick < 0.2 then return end
    lastClick = tick()
    uiHidden = not uiHidden
    pcall(function() Venyx:toggle() end)
end)

-- ==========================================================
--  CROSS (X) + SHUTDOWN
-- ==========================================================
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "SNX_Close"
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -28, 0, 8)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.ZIndex = 20
closeBtn.Parent = Venyx.container.Main.TopBar

local confirmGui = Instance.new("ScreenGui")
confirmGui.Name = "SNX_Confirm"
confirmGui.IgnoreGuiInset = true
confirmGui.ResetOnSpawn = false
confirmGui.DisplayOrder = 100000
pcall(function() confirmGui.Parent = panicParent end)
if not confirmGui.Parent then confirmGui.Parent = LP:WaitForChild("PlayerGui") end

local confirmBg = Instance.new("Frame", confirmGui)
confirmBg.Name = "Bg"
confirmBg.Size = UDim2.new(0, 320, 0, 160)
confirmBg.Position = UDim2.new(0.5, 0, 0.5, 0)
confirmBg.AnchorPoint = Vector2.new(0.5, 0.5)
confirmBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
confirmBg.BorderSizePixel = 0
confirmBg.Visible = false
local confirmCorner = Instance.new("UICorner", confirmBg)
confirmCorner.CornerRadius = UDim.new(0, 10)
local confirmStroke = Instance.new("UIStroke", confirmBg)
confirmStroke.Color = Color3.fromRGB(180, 80, 255)
confirmStroke.Thickness = 1.5

local confirmTitle = Instance.new("TextLabel", confirmBg)
confirmTitle.Size = UDim2.new(1, 0, 0, 40)
confirmTitle.Position = UDim2.new(0, 0, 0, 15)
confirmTitle.BackgroundTransparency = 1
confirmTitle.Font = Enum.Font.GothamBold
confirmTitle.Text = "Закрыть скрипт?"
confirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmTitle.TextSize = 20

local confirmSub = Instance.new("TextLabel", confirmBg)
confirmSub.Size = UDim2.new(1, -20, 0, 40)
confirmSub.Position = UDim2.new(0, 10, 0, 55)
confirmSub.BackgroundTransparency = 1
confirmSub.Font = Enum.Font.Gotham
confirmSub.Text = "SnapSanixHUB by wwxlove\nточно хочешь выйти? :3"
confirmSub.TextColor3 = Color3.fromRGB(180, 180, 180)
confirmSub.TextSize = 14
confirmSub.TextWrapped = true

local yesBtn = Instance.new("TextButton", confirmBg)
yesBtn.Size = UDim2.new(0, 120, 0, 36)
yesBtn.Position = UDim2.new(0, 30, 1, -56)
yesBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 255)
yesBtn.BorderSizePixel = 0
yesBtn.Font = Enum.Font.GothamBold
yesBtn.Text = "Да, закрыть"
yesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
yesBtn.TextSize = 14
local yesCorner = Instance.new("UICorner", yesBtn)
yesCorner.CornerRadius = UDim.new(0, 8)

local noBtn = Instance.new("TextButton", confirmBg)
noBtn.Size = UDim2.new(0, 120, 0, 36)
noBtn.Position = UDim2.new(1, -150, 1, -56)
noBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
noBtn.BorderSizePixel = 0
noBtn.Font = Enum.Font.GothamBold
noBtn.Text = "Отмена"
noBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noBtn.TextSize = 14
local noCorner = Instance.new("UICorner", noBtn)
noCorner.CornerRadius = UDim.new(0, 8)

local function showConfirm()
    confirmBg.Visible = true
    confirmBg.Size = UDim2.new(0, 0, 0, 0)
    TweenSvc:Create(confirmBg, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 320, 0, 160)}):Play()
end
local function hideConfirm()
    local t = TweenSvc:Create(confirmBg, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)})
    t:Play()
    t.Completed:Connect(function() confirmBg.Visible = false end)
end

closeBtn.MouseButton1Click:Connect(showConfirm)
noBtn.MouseButton1Click:Connect(hideConfirm)

local function shutdownAll()
    SNX_Closed = true
    pcall(function() stopFling() end)
    pcall(function()
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
        local hum = myHum()
        if hum then hum.PlatformStand = false end
    end)
    pcall(resetStretch)
    pcall(clearHitboxes)
    pcall(cleanupAll)
    pcall(function()
        if FovC then FovC.Visible = false FovC:Remove() end
    end)
    pcall(function()
        for _, t in pairs(Tracers) do
            pcall(function() t:Remove() end)
        end
        Tracers = {}
    end)
    pcall(function()
        local hum = myHum()
        if hum then
            hum.WalkSpeed = 16
            hum.UseJumpPower = true
            hum.JumpPower = 50
        end
    end)
    pcall(function()
        local c = LP.Character
        if c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end)
    pcall(function()
        Lighting.Brightness = OldLight.Brightness
        Lighting.Ambient = OldLight.Ambient
        Lighting.OutdoorAmbient = OldLight.OutdoorAmbient
        Lighting.FogEnd = OldLight.FogEnd
        Lighting.ClockTime = OldLight.ClockTime
    end)
    pcall(function()
        if SkyObj then SkyObj:Destroy() SkyObj = nil end
        if AtmoObj then AtmoObj:Destroy() AtmoObj = nil end
        restoreOriginalSkies()
    end)
    pcall(function()
        for _, conn in ipairs(SNX_Connections) do
            pcall(function() conn:Disconnect() end)
        end
        SNX_Connections = {}
    end)
    pcall(function() UIS.MouseIconEnabled = true end)
end

yesBtn.MouseButton1Click:Connect(function()
    confirmBg.Visible = false
    local container = Venyx.container and Venyx.container.Main
    if container then
        local startPos = container.Position
        local target = startPos + UDim2.new(0, 0, 0, 600)
        TweenSvc:Create(container, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Position = target}):Play()
        for _, obj in ipairs(container:GetDescendants()) do
            if obj:IsA("GuiObject") and not obj:IsA("ScreenGui") then
                pcall(function()
                    if obj.BackgroundTransparency < 1 then
                        TweenSvc:Create(obj, TweenInfo.new(1.4), {BackgroundTransparency = 1}):Play()
                    end
                    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                        TweenSvc:Create(obj, TweenInfo.new(1.4), {TextTransparency = 1}):Play()
                    end
                    if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                        TweenSvc:Create(obj, TweenInfo.new(1.4), {ImageTransparency = 1}):Play()
                    end
                end)
            end
        end
    end
    shutdownAll()
    task.wait(1.5)
    pcall(function() if Venyx.container then Venyx.container:Destroy() end end)
    pcall(function() PanicGui:Destroy() end)
    pcall(function() CursorGui:Destroy() end)
    pcall(function() confirmGui:Destroy() end)
end)

Venyx:Notify("SnapSanixHUB", "edited by wwxlove")
