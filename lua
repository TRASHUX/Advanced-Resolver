local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local players = game:GetService("Players")
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/vKhonshu/intro/main/ui"))()

local inputBegan = userInput.InputBegan
local player = players.LocalPlayer

-- Funcs

local SendNotif = function(text)
    NotifyLib.prompt("Information", text, 2.5)
end

-- Code

if not Resolver then
    SendNotif("Please use loadstring!")
    return
end

inputBegan:Connect(function(key)
    if key.KeyCode == Resolver.Bind and not userInput:GetFocusedTextBox() then
        if Resolver.Enabled then
            Resolver.Enabled = false

            if Resolver.Notify then
                SendNotif("Disabled")
            end
        else
            Resolver.Enabled = true
            
            if Resolver.Notify then
                SendNotif("Enabled")
            end
        end
    end
end)

runService.Heartbeat:Connect(function()
    if Resolver.Enabled then
        for i, Target in pairs(players:GetPlayers()) do
            if Target ~= player then
                for i, Part in pairs(Target.Character:GetDescendants()) do
                    if Part:IsA("BasePart") then
                        if Resolver.Type == "With Pred" then
                            Part.Velocity =
                                Target.Character.Humanoid.MoveDirection * Resolver.Prediction
                            Part.AssemblyLinearVelocity =
                                Target.Character.Humanoid.MoveDirection * Resolver.Prediction
                        else
                            Part.Velocity =
                                Part.Velocity * 0
                            Part.AssemblyLinearVelocity =
                                Part.AssemblyLinearVelocity * 0
                        end
                    end
                end
            end
        end
    end
end)
