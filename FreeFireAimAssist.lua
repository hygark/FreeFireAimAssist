-- FreeFireAimAssist.lua - Assistência avançada para Free Fire com aimbot, speed boost, noclip e fly
-- Criado por hygark (2022)
-- Descrição: Script Lua para automação em Free Fire, com mira automática (aimbot), movimento rápido (speed boost), simulação de noclip e fly (pulos elevados). Usa GUI Rayfield para configuração.
-- Nota: Use apenas para testes em ambientes privados (ex.: emuladores). Automação em jogos pode violar os Termos de Serviço do Free Fire.

-- Carregar biblioteca Rayfield para GUI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Configurações personalizáveis
local Settings = {
    AimbotFOV = 100,           -- Campo de visão para aimbot (pixels)
    AimbotDelay = 0.1,         -- Delay entre detecção e toque (segundos)
    TargetColor = "Red",       -- Cor do alvo (simulada, ajuste para emulador)
    SpeedBoostKey = "LeftShift", -- Tecla para speed boost
    SpeedBoostInterval = 0.05, -- Intervalo para presses rápidas
    NoclipSensitivity = 50,    -- Sensibilidade para evitar obstáculos (pixels)
    FlyJumpKey = "Space",      -- Tecla para fly (pulo)
    FlyHeight = 200,           -- Altura simulada para fly (pixels)
    LogWebhook = "",           -- URL de webhook para logging (ex.: Discord)
    MaxDetections = 5,         -- Máximo de alvos por frame
    StopFlag = false,          -- Flag para parar o script
    GuiEnabled = true,         -- Habilitar GUI
}

-- Estado do script
local ScriptState = {
    IsRunning = false,
    TotalDetections = 0,
    TotalClicks = 0,
    TotalSpeedBoosts = 0,
    TotalFlyJumps = 0,
    TotalNoclipAvoids = 0,
}

-- Função para enviar logs (console e webhook)
local function logMessage(level, message)
    print(string.format("[%s] [%s] %s", level, os.date("%Y-%m-%d %H:%M:%S"), message))
    if Settings.LogWebhook ~= "" then
        local data = {
            content = string.format("[%s] FreeFireAimAssist: %s", level, message)
        }
        local success, err = pcall(function()
            HttpService:PostAsync(Settings.LogWebhook, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
        end)
        if not success then
            print(string.format("[ERROR] Falha ao enviar log: %s", err))
        end
    end
end

-- Função para simular detecção de alvos (hipotética, depende de API de emulador)
local function detectTargets()
    -- Simulação: assume uma API de emulador que retorna posições de alvos
    -- Em produção, use integração com OpenCV via executor ou plugin
    local targets = {}
    -- Exemplo fictício: alvos em posições fixas para teste
    for i = 1, math.random(0, Settings.MaxDetections) do
        table.insert(targets, {
            x = math.random(100, Settings.Viewport.width - 100),
            y = math.random(100, Settings.Viewport.height - 100),
            area = math.random(1000, 5000)
        })
    end
    return targets
end

-- Função para simular detecção de obstáculos (para noclip)
local function detectObstacles()
    -- Simulação: assume obstáculos detectados em posições fixas
    local obstacles = {}
    for i = 1, math.random(0, 2) do
        table.insert(obstacles, {
            x = math.random(100, Settings.Viewport.width - 100),
            y = math.random(100, Settings.Viewport.height - 100),
            width = 50,
            height = 50
        })
    end
    return obstacles
end

-- Função para simular toque (substitui click em emuladores)
local function simulateTouch(x, y)
    -- Simula toque via API de emulador (exemplo fictício)
    -- Substitua por API real do executor/emulador
    logMessage("INFO", string.format("Toque simulado em (%d, %d)", x, y))
    ScriptState.TotalClicks = ScriptState.TotalClicks + 1
end

-- Função para simular speed boost
local function simulateSpeedBoost()
    -- Simula presses rápidos da tecla configurada
    logMessage("INFO", "Speed boost simulado.")
    ScriptState.TotalSpeedBoosts = ScriptState.TotalSpeedBoosts + 1
    -- Em produção, use API de emulador para pressionar tecla
end

-- Função para simular noclip
local function simulateNoclip(obstacles)
    if #obstacles > 0 then
        local obstacle = obstacles[1]
        -- Simula desvio movendo cursor/toque para fora do obstáculo
        logMessage("INFO", "Noclip: Obstáculo evitado.")
        ScriptState.TotalNoclipAvoids = ScriptState.TotalNoclipAvoids + 1
    end
end

-- Função para simular fly
local function simulateFly()
    -- Simula pulo elevado
    logMessage("INFO", "Fly simulado com pulo.")
    ScriptState.TotalFlyJumps = ScriptState.TotalFlyJumps + 1
    -- Em produção, use API de emulador para pressionar tecla de pulo
end

-- Função principal para aim assist
local function aimAssist()
    if ScriptState.IsRunning then
        logMessage("ERROR", "Script já está em execução!")
        return
    end
    ScriptState.IsRunning = true
    logMessage("INFO", "FreeFireAimAssist iniciado.")

    local connection
    connection = RunService.Heartbeat:Connect(function()
        if Settings.StopFlag then
            connection:Disconnect()
            ScriptState.IsRunning = false
            logMessage("INFO", "FreeFireAimAssist parado.")
            return
        end

        -- Detectar alvos e obstáculos
        local targets = detectTargets()
        local obstacles = detectObstacles()

        -- Aimbot
        if #targets > 0 then
            for _, target in ipairs(targets) do
                if (target.x - Settings.Viewport.width/2)^2 + (target.y - Settings.Viewport.height/2)^2 <= Settings.AimbotFOV^2 then
                    simulateTouch(target.x, target.y)
                    task.wait(Settings.AimbotDelay)
                end
            end
        else
            logMessage("INFO", "Nenhum alvo detectado neste frame.")
        end

        -- Speed Boost, Noclip e Fly (aleatórios para simulação)
        if math.random() < 0.3 then simulateSpeedBoost() end
        simulateNoclip(obstacles)
        if math.random() < 0.2 then simulateFly() end
    end)
end

-- Criar GUI com Rayfield
if Settings.GuiEnabled then
    local Window = Rayfield:CreateWindow({
        Name = "FreeFireAimAssist GUI - Inflavelle",
        LoadingTitle = "FreeFire Aim Assist",
        LoadingSubtitle = "by Inflavelle",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "FreeFireAimAssist",
            FileName = "Config"
        }
    })

    local MainTab = Window:CreateTab("Main")
    MainTab:CreateToggle({
        Name = "Aimbot",
        CurrentValue = false,
        Flag = "AimbotToggle",
        Callback = function(value)
            if value then aimAssist() else Settings.StopFlag = true end
        end
    })

    MainTab:CreateSlider({
        Name = "Aimbot FOV",
        Range = {10, 500},
        Increment = 10,
        Suffix = "Pixels",
        CurrentValue = Settings.AimbotFOV,
        Flag = "AimbotFOVSlider",
        Callback = function(value)
            Settings.AimbotFOV = value
            logMessage("INFO", "Aimbot FOV atualizado para: " .. value)
        end
    })

    MainTab:CreateSlider({
        Name = "Aimbot Delay",
        Range = {0.01, 1},
        Increment = 0.01,
        Suffix = "Seconds",
        CurrentValue = Settings.AimbotDelay,
        Flag = "AimbotDelaySlider",
        Callback = function(value)
            Settings.AimbotDelay = value
            logMessage("INFO", "Aimbot Delay atualizado para: " .. value)
        end
    })

    MainTab:CreateToggle({
        Name = "Speed Boost",
        CurrentValue = false,
        Flag = "SpeedBoostToggle",
        Callback = function(value)
            if value then simulateSpeedBoost() end
        end
    })

    MainTab:CreateToggle({
        Name = "Fly",
        CurrentValue = false,
        Flag = "FlyToggle",
        Callback = function(value)
            if value then simulateFly() end
        end
    })

    Rayfield:LoadConfiguration()
end

-- Parar com tecla ESC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Escape then
        Settings.StopFlag = true
    end
end)

-- Iniciar aimbot automaticamente se GUI não estiver habilitada
if not Settings.GuiEnabled then
    aimAssist()
end