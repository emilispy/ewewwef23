local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "OG bubble gum nigger - v1.0.4",
   LoadingTitle = "Loading GUI..",
   LoadingSubtitle = "",
   KeySystem = false,  
   KeySettings = {
      Title = "Access Point",
      Subtitle = ".gg/uKh2AGP2b3",
      Note = "🗝️ Key: BGS_GamesAreFun",
      GrabKeyFromSite = false,
      Key = "BGS_GamesAreFun"
   }
})

local MainTab = Window:CreateTab("⚡ Main", nil)
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Executor supported!",
   Content = "Script Loaded",
   Duration = 5,
   Image = 15540208318,
   Actions = {
      Ignore = {
         Name = "Okay",
         Callback = function() end
      },
   },
})

local autoBlowEnabled = false 
local function autoBlow()
   while autoBlowEnabled do
      game:GetService("ReplicatedStorage").Assets.Remotes.BlowBubble:FireServer()
      wait(0.05)
   end
end

local AutoBlowToggle = MainTab:CreateToggle({
   Name = "Auto Blow",
   CurrentValue = false,
   Flag = "autoblow",
   Callback = function(Value)
      autoBlowEnabled = Value
      if Value then
         task.spawn(autoBlow)
      end
   end,
})

local autoHatchEnabled = false
local function autoHatch()
   while autoHatchEnabled do
      game:GetService("ReplicatedStorage").Assets.Remotes.PurchaseEgg:FireServer("Slushy Egg")
      wait(0.0001)
   end
end

local AutoHatchToggle = MainTab:CreateToggle({
   Name = "Fast Hatch",
   CurrentValue = false,
   Flag = "autohatch",
   Callback = function(Value)
      autoHatchEnabled = Value
      if Value then
         task.spawn(autoHatch)
      end
   end,
})

local TweenService = game:GetService("TweenService")
local autoPickupEnabled = false

local function autoPickup()
    while autoPickupEnabled do
        local character = game.Players.LocalPlayer.Character
        if not character or not character.PrimaryPart then
            task.wait(0.1)
            continue
        end

        for _, pickup in ipairs(game.Workspace.Pickups:GetChildren()) do
            if not autoPickupEnabled then break end
            local targetPart = pickup:IsA("BasePart") and pickup or pickup:FindFirstChildWhichIsA("BasePart")

            if targetPart then
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear) -- Adjust speed here
                local goal = { CFrame = targetPart.CFrame }

                local tween = TweenService:Create(character.PrimaryPart, tweenInfo, goal)
                tween:Play()
                tween.Completed:Wait()
            end
        end
    end
end

local AutoPickupToggle = MainTab:CreateToggle({
    Name = "Auto Pickup",
    CurrentValue = false,
    Flag = "autopickup",
    Callback = function(Value)
        autoPickupEnabled = Value
        if Value then
            task.spawn(autoPickup)
        end
    end,
})


local autoAchievementsEnabled = false
local function autoAchievements()
   while autoAchievementsEnabled do
      for i = 1, 4 do
         local args = {
            [1] = i 
         }
         game:GetService("ReplicatedStorage").Assets.Remotes.ClaimAchievement:FireServer(unpack(args))
         wait(0.1)
      end
   end
end

local AutoAchievementsToggle = MainTab:CreateToggle({
   Name = "Auto Achievements",
   CurrentValue = false,
   Flag = "autoachievements",
   Callback = function(Value)
      autoAchievementsEnabled = Value
      if Value then
         task.spawn(autoAchievements)
      end
   end,
})

local RedeemCodesButton = MainTab:CreateButton({
   Name = "Redeem Codes",
   Callback = function()
      local codes = {"REEE-", "TwitterRelease", "FreeEgg", "FreeCoins", "LotsOfGems", "ObscureEntity", "sircfenner", "SweetGems", "SuperCoins", "SuperGems", "Spotted", "Sylently", "Christmas", "Santa", "CandyCanes"}
      for _, code in ipairs(codes) do
         local args = {
            [1] = code
         }
         game:GetService("ReplicatedStorage").Assets.Remotes.RedeemCode:InvokeServer(unpack(args))
      end
   end,
})

local MiscTab = Window:CreateTab("➕ Misc", nil)
local UnlockAllOverworld = MiscTab:CreateButton({
   Name = "Unlock Islands",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local overworld = game.Workspace:FindFirstChild("FloatingIslands") and game.Workspace.FloatingIslands:FindFirstChild("Overworld")
      if overworld then
         for _, island in ipairs(overworld:GetChildren()) do
            local tp = island:FindFirstChild("TeleportPoint")
            if tp then
               char:SetPrimaryPartCFrame(tp.CFrame)
               wait(0.1)
            end
         end
      end
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.Health = 0
      end
   end,
})
