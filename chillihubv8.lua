-- [[ Chilli Hub V8 - Modern Rainbow Key System ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Cấu hình lưu key ẩn 24 giờ (Dùng file cục bộ của Roblox nếu được hỗ trợ, hoặc biến cache session)
local KEY_FILE = "ChilliHubV8_SavedKey.json"
local CORRECT_KEY = "ChilliHubV8KeyKakwo - LapqlekieiahOaowihe"

local function isKeyValid()
    if pcall(function() readfile(KEY_FILE) end) then
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile(KEY_FILE))
        end)
        if success and data and data.key == CORRECT_KEY then
            -- Kiểm tra thời hạn 24 giờ (86400 giây)
            if os.time() - data.time < 86400 then
                return true
            end
        end
    end
    return false
end

local function saveKey()
    pcall(function()
        local data = {
            key = CORRECT_KEY,
            time = os.time()
        }
        writefile(KEY_FILE, game:GetService("HttpService"):JSONEncode(data))
    end)
end

-- Nếu đã lưu key hợp lệ trong 24h thì bỏ qua bảng key và load thẳng script luôn
if isKeyValid() then
    task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/napun67/stealanegg/refs/heads/main/chillihubv8.lua"))()
    end)
    return
end

-- Kiểm tra và dọn dẹp UI cũ nếu trùng lặp
if CoreGui:FindFirstChild("ChilliHubKeySystem") then
    CoreGui.ChilliHubKeySystem:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChilliHubKeySystem"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

-- Khung chính (To và rộng)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -135)
MainFrame.Size = UDim2.new(0, 420, 0, 270)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Viền Rainbow Cầu Vồng Mượt Mà
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2.5
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.004) % 1
    MainStroke.Color = Color3.fromHSV(hue, 0.8, 1)
end)

-- Tiêu đề Chilli Hub V8
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Size = UDim2.new(1, 0, 0, 28)
Title.Font = Enum.Font.FredokaOne
Title.Text = "CHILLI HUB V8"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24

-- Dòng chữ phụ đề tiếng Anh bên dưới tiêu đề
local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Parent = MainFrame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 50)
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.Text = "Please enter your key below"
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 175)
Subtitle.TextSize = 13

-- Nút đóng UI
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -36, 0, 12)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Font = Enum.Font.FredokaOne
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
CloseBtn.TextSize = 15

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Ô nhập Key (Chống tràn viền khi key dài)
local TextBox = Instance.new("TextBox")
TextBox.Parent = MainFrame
TextBox.BackgroundColor3 = Color3.fromRGB(22, 22, 29)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.08, 0, 0, 85)
TextBox.Size = UDim2.new(0.84, 0, 0, 46)
TextBox.Font = Enum.Font.GothamMedium
TextBox.PlaceholderText = "Enter key here..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 115)
TextBox.TextSize = 13
TextBox.ClearTextOnFocus = false
TextBox.ClipsDescendants = true

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 10)
BoxCorner.Parent = TextBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Color3.fromRGB(45, 45, 55)
BoxStroke.Thickness = 1
BoxStroke.Parent = TextBox

-- Phần thông báo hiện đại
local StatusContainer = Instance.new("Frame")
StatusContainer.Name = "StatusContainer"
StatusContainer.Parent = MainFrame
StatusContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
StatusContainer.BackgroundTransparency = 1 
StatusContainer.BorderSizePixel = 0
StatusContainer.Position = UDim2.new(0.08, 0, 0, 138)
StatusContainer.Size = UDim2.new(0.84, 0, 0, 26)

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 6)
StatusCorner.Parent = StatusContainer

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = StatusContainer
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0, 0)
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

local function showStatus(text, type)
    StatusContainer.BackgroundTransparency = 0.25
    if type == "error" then
        StatusContainer.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
        StatusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
    elseif type == "success" then
        StatusContainer.BackgroundColor3 = Color3.fromRGB(20, 45, 25)
        StatusLabel.TextColor3 = Color3.fromRGB(90, 255, 140)
    elseif type == "info" then
        StatusContainer.BackgroundColor3 = Color3.fromRGB(20, 35, 45)
        StatusLabel.TextColor3 = Color3.fromRGB(90, 200, 255)
    end
    StatusLabel.Text = text
    
    StatusContainer.Size = UDim2.new(0, 0, 0, 26)
    StatusContainer.Position = UDim2.new(0.5, 0, 0, 138)
    TweenService:Create(StatusContainer, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.84, 0, 0, 26),
        Position = UDim2.new(0.08, 0, 0, 138)
    }):Play()
end

-- Nút CHECK KEY
local CheckBtn = Instance.new("TextButton")
CheckBtn.Parent = MainFrame
CheckBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
CheckBtn.Position = UDim2.new(0.08, 0, 0, 178)
CheckBtn.Size = UDim2.new(0.40, 0, 0, 48)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.Text = "CHECK KEY"
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.TextSize = 14

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 10)
CheckCorner.Parent = CheckBtn

local CheckStroke = Instance.new("UIStroke")
CheckStroke.Color = Color3.fromRGB(60, 60, 75)
CheckStroke.Thickness = 1
CheckStroke.Parent = CheckBtn

-- Nút GET KEY
local GetBtn = Instance.new("TextButton")
GetBtn.Parent = MainFrame
GetBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
GetBtn.Position = UDim2.new(0.52, 0, 0, 178)
GetBtn.Size = UDim2.new(0.40, 0, 0, 48)
GetBtn.Font = Enum.Font.GothamBold
GetBtn.Text = "GET KEY"
GetBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
GetBtn.TextSize = 14

local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0, 10)
GetCorner.Parent = GetBtn

local GetStroke = Instance.new("UIStroke")
GetStroke.Color = Color3.fromRGB(45, 45, 55)
GetStroke.Thickness = 1
GetStroke.Parent = GetBtn

-- Hiệu ứng lắc nhẹ siêu mượt bằng TweenService
local function smoothShake()
    local basePos = UDim2.new(0.5, -210, 0.5, -135)
    local offsets = {12, -10, 8, -6, 4, -2, 0}
    
    for _, offset in ipairs(offsets) do
        local tween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.035, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {Position = basePos + UDim2.new(0, offset, 0, 0)}
        )
        tween:Play()
        tween.Completed:Wait()
    end
end

-- Xử lý CHECK KEY
CheckBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CORRECT_KEY then
        saveKey() -- Lưu key ẩn 24 giờ
        showStatus("✓ Key Accepted! Loading script...", "success")
        
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.wait(0.6)
        ScreenGui:Destroy()
        
        task.spawn(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/napun67/stealanegg/refs/heads/main/chillihubv8.lua"))()
        end)
    else
        showStatus("✕ Invalid Key! Please try again.", "error")
        TextBox.Text = "" -- Tự động xóa chữ
        smoothShake()
    end
end)

-- Xử lý GET KEY với link mới
GetBtn.MouseButton1Click:Connect(function()
    setclipboard("https://link4m.net/Gka5Xl")
    showStatus("ℹ Link copied to clipboard!", "info")
end)
