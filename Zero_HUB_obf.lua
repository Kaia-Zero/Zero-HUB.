local textToCopy = [[
loadstring(game:HttpGet("https://tinyurl.com/Zero-HUB-XD"))()
]]

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuickCopyGUI"
ScreenGui.ResetOnSpawn = false

local success, err = pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not success then
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ไปใช้ตัวนี้แทน นะคับ 😅"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TopBar

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- กล่องสำหรับใส่ข้อความ (มี Scrollbar เผื่อข้อความยาว)
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 0, 110)
ScrollFrame.Position = UDim2.new(0, 10, 0, 45)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = MainFrame

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 6)
ScrollCorner.Parent = ScrollFrame

-- ช่องแสดงข้อความ (ล็อกไม่ให้แก้)
local TextBox = Instance.new("TextBox")
TextBox.Name = "TextBox"
TextBox.Size = UDim2.new(1, 0, 1, 0)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 14
TextBox.Font = Enum.Font.SourceSans
TextBox.Text = textToCopy -- นำข้อความจากด้านบนมาแสดง
TextBox.TextWrapped = true
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.ClearTextOnFocus = false
TextBox.TextEditable = false -- 🔒 ล็อกไม่ให้พิมพ์แก้
TextBox.Parent = ScrollFrame

local TextBoxPadding = Instance.new("UIPadding")
TextBoxPadding.PaddingTop = UDim.new(0, 8)
TextBoxPadding.PaddingLeft = UDim.new(0, 8)
TextBoxPadding.PaddingRight = UDim.new(0, 8)
TextBoxPadding.Parent = TextBox

local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(1, -20, 0, 40)
CopyButton.Position = UDim2.new(0, 10, 0, 170)
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.Text = "คัดลอกข้อความ (Copy)"
CopyButton.TextSize = 16
CopyButton.Font = Enum.Font.SourceSansBold
CopyButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = CopyButton

CopyButton.MouseButton1Click:Connect(function()
    -- คัดลอกข้อความจากตัวแปร textToCopy โดยตรง
    if setclipboard then
        setclipboard(textToCopy)
    elseif toclipboard then
        toclipboard(textToCopy)
    end
    
    CopyButton.Text = "คัดลอกสำเร็จ! ✅"
    CopyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    task.wait(1.5)
    CopyButton.Text = "คัดลอกข้อความ (Copy)"
    CopyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)

-- ระบบลากหน้าต่าง
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
