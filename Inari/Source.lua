if getgenv().Library then
	getgenv().Library:Unload()
end;
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera;
local NewInstance = Instance.new;
local Color3FromRGB = Color3.fromRGB;
local Color3FromHSV = Color3.fromHSV;
local Color3FromHex = Color3.fromHex;
local NewUDim2 = UDim2.new;
local NewUDim = UDim.new;
local NewVector2 = Vector2.new;
local NewRect = Rect.new;
local Library = {}
do
	Library = {
		Flags = {},
		Theme = {
			["Background"] = Color3FromRGB(13, 13, 13),
			["Inline"] = Color3FromRGB(16, 16, 16),
			["Text"] = Color3FromRGB(229, 229, 229),
			["Border"] = Color3FromRGB(34, 34, 34),
			["Accent"] = Color3FromRGB(131, 194, 242),
			["Element"] = Color3FromRGB(15, 15, 15),
			["Text Border"] = Color3FromRGB(0, 0, 0)
		},
		Folders = {
			Directory = "inari",
			Configs = "inari/Configs",
			Fonts = "inari/Fonts"
		},
		MenuKey = Enum.KeyCode.End,
		TweeningTime = 0.215,
		TweeningStyle = "Quint",
		TweeningDirection = "Out",
		HoverEffects = true,
		UnnamedFlags = 0,
		Font = nil,
		Holder = nil,
		NotifHolder = nil,
		KeyList = nil,
		Connections = {},
		ThemeMap = {},
		ThemeInstances = {},
		Sections = {},
		Pages = {}
	}
	Library.__index = Library;
	Library.Sections.__index = Library.Sections;
	Library.Pages.__index = Library.Pages;
	local KeyNames = {
		[Enum.KeyCode.LeftShift] = "LS",
		[Enum.KeyCode.RightShift] = "RS",
		[Enum.KeyCode.LeftControl] = "LC",
		[Enum.KeyCode.RightControl] = "RC",
		[Enum.KeyCode.Insert] = "INS",
		[Enum.KeyCode.Backspace] = "BS",
		[Enum.KeyCode.Return] = "Ent",
		[Enum.KeyCode.LeftAlt] = "LA",
		[Enum.KeyCode.RightAlt] = "RA",
		[Enum.KeyCode.CapsLock] = "CAPS",
		[Enum.KeyCode.Delete] = "DEL",
		[Enum.KeyCode.Home] = "HOME",
		[Enum.KeyCode.End] = "END",
		[Enum.KeyCode.PageUp] = "PGUP",
		[Enum.KeyCode.PageDown] = "PGDN",
		[Enum.KeyCode.Up] = "UP",
		[Enum.KeyCode.Down] = "DOWN",
		[Enum.KeyCode.Left] = "LEFT",
		[Enum.KeyCode.Right] = "RIGHT",
		[Enum.UserInputType.MouseButton1] = "MB1",
		[Enum.UserInputType.MouseButton2] = "MB2",
		[Enum.UserInputType.MouseButton3] = "MB3",
		[Enum.KeyCode.One] = "1",
		[Enum.KeyCode.Two] = "2",
		[Enum.KeyCode.Three] = "3",
		[Enum.KeyCode.Four] = "4",
		[Enum.KeyCode.Five] = "5",
		[Enum.KeyCode.Six] = "6",
		[Enum.KeyCode.Seven] = "7",
		[Enum.KeyCode.Eight] = "8",
		[Enum.KeyCode.Nine] = "9",
		[Enum.KeyCode.Zero] = "0",
		[Enum.KeyCode.KeypadOne] = "Num1",
		[Enum.KeyCode.KeypadTwo] = "Num2",
		[Enum.KeyCode.KeypadThree] = "Num3",
		[Enum.KeyCode.KeypadFour] = "Num4",
		[Enum.KeyCode.KeypadFive] = "Num5",
		[Enum.KeyCode.KeypadSix] = "Num6",
		[Enum.KeyCode.KeypadSeven] = "Num7",
		[Enum.KeyCode.KeypadEight] = "Num8",
		[Enum.KeyCode.KeypadNine] = "Num9",
		[Enum.KeyCode.KeypadZero] = "Num0",
		[Enum.KeyCode.Minus] = "-",
		[Enum.KeyCode.Equals] = "=",
		[Enum.KeyCode.Tilde] = "~",
		[Enum.KeyCode.LeftBracket] = "[",
		[Enum.KeyCode.RightBracket] = "]",
		[Enum.KeyCode.RightParenthesis] = ")",
		[Enum.KeyCode.LeftParenthesis] = "(",
		[Enum.KeyCode.Semicolon] = ",",
		[Enum.KeyCode.Quote] = "'",
		[Enum.KeyCode.BackSlash] = "\\",
		[Enum.KeyCode.Comma] = ",",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Slash] = "/",
		[Enum.KeyCode.Asterisk] = "*",
		[Enum.KeyCode.Plus] = "+",
		[Enum.KeyCode.Backquote] = "`",
		[Enum.KeyCode.Escape] = "ESC",
		[Enum.KeyCode.Space] = "SPC",
		[Enum.KeyCode.Z] = "Z",
		[Enum.KeyCode.X] = "X",
		[Enum.KeyCode.C] = "C",
		[Enum.KeyCode.V] = "V",
		[Enum.KeyCode.B] = "B",
		[Enum.KeyCode.N] = "N",
		[Enum.KeyCode.M] = "M",
		[Enum.KeyCode.A] = "A",
		[Enum.KeyCode.S] = "S",
		[Enum.KeyCode.D] = "D",
		[Enum.KeyCode.F] = "F",
		[Enum.KeyCode.G] = "G",
		[Enum.KeyCode.H] = "H",
		[Enum.KeyCode.J] = "J",
		[Enum.KeyCode.K] = "K",
		[Enum.KeyCode.L] = "L",
		[Enum.KeyCode.Q] = "Q",
		[Enum.KeyCode.W] = "W",
		[Enum.KeyCode.E] = "E",
		[Enum.KeyCode.R] = "R",
		[Enum.KeyCode.T] = "T",
		[Enum.KeyCode.Y] = "Y",
		[Enum.KeyCode.U] = "U",
		[Enum.KeyCode.I] = "I",
		[Enum.KeyCode.O] = "O",
		[Enum.KeyCode.P] = "P"
	}
	for _, folderPath in Library.Folders do
		if not isfolder(folderPath) then
			makefolder(folderPath)
		end
	end;
	function Library:GetFolder(folderKey, addSlash)
		local path = Library.Folders[folderKey]
		if path ~= nil then
			return
		end;
		if addSlash then
			path ..= "/"
		end;
		return path
	end;
	writefile = writefile or function()
	end;
	readfile = readfile or function()
	end;
	isfile = isfile or function()
	end;
	delfile = delfile or function()
	end;
	isfolder = isfolder or function()
	end;
	makefolder = makefolder or function()
	end;
	listfiles = listfiles or function()
	end;
	getgenv = getgenv or function()
	end;
	getcustomasset = getcustomasset or function()
	end;
	cloneref = cloneref or function()
		return CoreGui
	end;
	gethui = gethui or function()
		return cloneref(game:GetService("CoreGui"))
	end;
	local TweenUtil = {}
	do
		TweenUtil.__index = TweenUtil;
		function TweenUtil.Create(_, instanceOrWrapper, tweenInfo, properties, useRawInstance)
			if not(instanceOrWrapper or properties) then
				return
			end;
			tweenInfo = tweenInfo or TweenInfo.new(Library.TweeningTime, Enum.EasingStyle[Library.TweeningStyle], Enum.EasingDirection[Library.TweeningDirection])
			local target = not useRawInstance and instanceOrWrapper.Object or instanceOrWrapper;
			local tweenObj = {
				Info = tweenInfo,
				Object = instanceOrWrapper,
				Tween = TweenService:Create(target, tweenInfo, properties)
			}
			setmetatable(tweenObj, TweenUtil)
			tweenObj.Tween:Play()
			return tweenObj
		end;
		function TweenUtil.Get(self)
			assert(self.Tween, "Tween doesn't exist")
			return self.Tween, self.Object, self.Info
		end;
		function TweenUtil.Play(self)
			assert(self.Tween, "Tween doesn't exist")
			self.Tween:Play()
		end;
		function TweenUtil.Pause(self)
			assert(self.Tween, "Tween doesn't exist")
			self.Tween:Pause()
		end;
		function TweenUtil.Clean(self)
			assert(self.Tween, "Tween doesn't exist")
			self.Tween:Pause()
			self = nil
		end
	end;
	local InstanceUtil = {}
	do
		InstanceUtil.__index = InstanceUtil;
		function InstanceUtil.Create(_, className, properties)
			local wrapper = {
				Object = NewInstance(className),
				Properties = properties,
				Class = className,
				Dragging = false
			}
			setmetatable(wrapper, InstanceUtil)
			for prop, value in properties do
				wrapper.Object[prop] = value
			end;
			return wrapper
		end;
		function InstanceUtil.Border(self)
			assert(self.Object, "Object doesn't exist")
			local stroke = InstanceUtil:Create("UIStroke", {
				Parent = self.Object,
				Color = Library.Theme.Border,
				Thickness = 1,
				LineJoinMode = Enum.LineJoinMode.Miter,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			})
			stroke:AddToTheme({
				Color = "Border"
			})
			return stroke
		end;
		function InstanceUtil.AddHoverEffect(self, useGrandparent)
			assert(self.Object, "Object doesn't exist")
			local hoverTarget = self.Object.Parent;
			if useGrandparent then
				hoverTarget = hoverTarget.Parent
			end;
			Library:Connect(hoverTarget.MouseEnter, function()
				if not Library.HoverEffects then
					return
				end;
				self:Tween(nil, {
					Color = Library.Theme.Accent
				})
				self:ChangeObjectTheme({
					Color = "Accent"
				})
			end, self.Object.Name .. " Hover Effect Enter")
			Library:Connect(hoverTarget.MouseLeave, function()
				if not Library.HoverEffects then
					return
				end;
				self:Tween(nil, {
					Color = Library.Theme.Border
				})
				self:ChangeObjectTheme({
					Color = "Border"
				})
			end, self.Object.Name .. " Hover Effect Leave")
		end;
		function InstanceUtil.TextBorder(self)
			assert(self.Object, "Object doesn't exist")
			local stroke = InstanceUtil:Create("UIStroke", {
				Parent = self.Object,
				Color = Library.Theme.TextBorder,
				Thickness = 1,
				LineJoinMode = Enum.LineJoinMode.Miter,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
			})
			stroke:AddToTheme({
				Color = "Text Border"
			})
			return stroke
		end;
		function InstanceUtil.Tween(self, tweenInfo, properties)
			assert(self.Object, "Object doesn't exist")
			return TweenUtil:Create(self.Object, tweenInfo, properties, true)
		end;
		function InstanceUtil.Connect(self, eventName, callback, connectionName)
			assert(self.Object, "Object doesn't exist")
			assert(self.Object[eventName], "Event doesn't exist")
			return Library:Connect(self.Object[eventName], callback, connectionName)
		end;
		function InstanceUtil.Disconnect(self, connectionName)
			for _, conn in Library.Connections do
				if conn.Name == connectionName then
					conn.Connection:Disconnect()
					break
				end
			end
		end;
		function InstanceUtil.MakeDraggable(self)
			assert(self.Object, "Object doesn't exist")
			local frame = self.Object;
			local wrapper = self;
			local isDragging = false;
			local dragStart, startPos = NewUDim2(), NewUDim2()
			local function onDrag(input)
				local delta = input.Position - dragStart;
				TweenUtil:Create(wrapper, TweenInfo.new(0.175, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Position = NewUDim2(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				})
			end;
			wrapper:Connect("InputBegan", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = true;
					dragStart = input.Position;
					startPos = frame.Position
				end
			end, frame.Name .. " Dragify Input Began")
			wrapper:Connect("InputEnded", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDragging = false
				end
			end, frame.Name .. " Dragify Input Ended")
			Library:Connect(UserInputService.InputChanged, function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
					onDrag(input)
				end
			end, frame.Name .. " Dragify Input Changed")
			return isDragging
		end;
		function InstanceUtil.MakeResizeable(self, minSize, maxSize)
			assert(self.Object, "Object doesn't exist")
			assert(minSize, "Minimum value can't be nil")
			assert(maxSize, "Maximum value can't be nil")
			local frame = self.Object;
			local wrapper = self;
			local isResizing = false;
			local sizeOffset, newSize = NewUDim2(), NewUDim2()
			local maxBounds = frame.Parent.AbsoluteSize - frame.AbsoluteSize;
			local resizeHandle = InstanceUtil:Create("TextButton", {
				Parent = frame,
				AnchorPoint = NewVector2(1, 1),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(0, 8, 0, 8),
				Position = NewUDim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = ""
			})
			resizeHandle:Connect("InputBegan", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isResizing = true;
					sizeOffset = frame.Size - NewUDim2(0, input.Position.X, 0, input.Position.Y)
				end
			end, frame.Name .. " Resizing Input Began")
			resizeHandle:Connect("InputEnded", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isResizing = false
				end
			end, frame.Name .. " Resizing Input Ended")
			Library:Connect(UserInputService.InputChanged, function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and isResizing then
					maxBounds = maxSize or frame.Parent.AbsoluteSize - frame.AbsoluteSize;
					newSize = sizeOffset + NewUDim2(0, input.Position.X, 0, input.Position.Y)
					newSize = NewUDim2(0, math.clamp(newSize.X.Offset, minSize.X, maxBounds.X), 0, math.clamp(newSize.Y.Offset, minSize.Y, maxBounds.Y))
					TweenUtil:Create(wrapper, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						Size = newSize
					})
				end
			end, frame.Name .. " Resizing Input Changed")
			return isResizing
		end;
		function InstanceUtil.Clean(self)
			assert(self.Object, "Object doesn't exist")
			self.Object:Destroy()
			self = nil
		end;
		function InstanceUtil.AddToTheme(self, themeMap)
			assert(self.Object, "Object doesn't exist")
			Library:AddToTheme(self, themeMap)
		end;
		function InstanceUtil.ChangeObjectTheme(self, themeMap)
			assert(self.Object, "Object doesn't exist")
			Library:ChangeObjectTheme(self, themeMap)
		end
	end;
	local FontUtil = {}
	do
		function FontUtil:New(name, weight, style, options)
			if isfile(Library.Folders.Fonts .. "/" .. name .. ".json") then
				return Font.new(getcustomasset(Library.Folders.Fonts .. "/" .. name .. ".json"))
			end;
			if not isfile(Library.Folders.Fonts .. "/" .. name .. ".ttf") then
				writefile(Library.Folders.Fonts .. "/" .. name .. ".ttf", game:HttpGet(options.Url))
			end;
			local fontData = {
				name = name,
				faces = {
					{
						name = "Regular",
						weight = weight,
						style = style,
						assetId = getcustomasset(Library.Folders.Fonts .. "/" .. name .. ".ttf")
					}
				}
			}
			writefile(Library.Folders.Fonts .. "/" .. name .. ".json", HttpService:JSONEncode(fontData))
			return Font.new(getcustomasset(Library.Folders.Fonts .. "/" .. name .. ".json"))
		end;
		function FontUtil:Get(name)
			if isfile(Library.Folders.Fonts .. "/" .. name .. ".json") then
				return Font.new(getcustomasset(Library.Folders.Fonts .. "/" .. name .. ".json"))
			end
		end;
		FontUtil:New("Proggy Clean", 400, "Regular", {
			Url = "https://github.com/bluescan/proggyfonts/raw/refs/heads/master/ProggyOriginal/ProggyClean.ttf"
		})
		Library.Font = FontUtil:Get("Proggy Clean")
	end;
	do
		Library.Holder = InstanceUtil:Create("ScreenGui", {
			Parent = gethui(),
			Name = "\0",
			ZIndexBehavior = Enum.ZIndexBehavior.Global,
			ResetOnSpawn = false
		})
		Library.NotifHolder = InstanceUtil:Create("Frame", {
			Parent = Library.Holder.Object,
			Name = "\0",
			BackgroundTransparency = 1,
			Size = NewUDim2(0, 0, 1, 0),
			BorderColor3 = Color3FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = Color3FromRGB(255, 255, 255)
		})
		InstanceUtil:Create("UIListLayout", {
			Parent = Library.NotifHolder.Object,
			Padding = NewUDim(0, 7),
			SortOrder = Enum.SortOrder.LayoutOrder
		})
		InstanceUtil:Create("UIPadding", {
			Parent = Library.NotifHolder.Object,
			PaddingTop = NewUDim(0, 8),
			PaddingBottom = NewUDim(0, 8),
			PaddingRight = NewUDim(0, 8),
			PaddingLeft = NewUDim(0, 8)
		})
		function Library:Thread(fn)
			local co = coroutine.create(fn)
			return function(...)
				return coroutine.resume(co, ...)
			end
		end;
		function Library:Unload()
			for _, conn in Library.Connections do
				conn.Signal:Disconnect()
			end;
			if Library.Holder then
				Library.Holder:Clean()
			end;
			Library = nil;
			getgenv().Library = nil
		end;
		function Library:Connect(signal, callback, name)
			local conn = {
				Signal = signal:Connect(callback),
				Name = name,
				Function = callback
			}
			table.insert(Library.Connections, conn)
			return conn
		end;
		function Library:Disconnect(name)
			for _, conn in Library.Connections do
				if conn.Name == name then
					conn.Signal:Disconnect()
					break
				end
			end
		end;
		function Library:GetConfig()
			local config = {}
			local ok, err = pcall(function()
				for flag, flagObj in Library.Flags do
					local class = flagObj.Class;
					if not class then
						continue
					end;
					if class == "Keybind" then
						config[flag] = {
							Name = flagObj.Key,
							Mode = flagObj.Mode
						}
					elseif class == "Colorpicker" then
						config[flag] = {
							Color = flagObj.Hex,
							Alpha = flagObj.Alpha
						}
					else
						if not config[flag] then
							config[flag] = flagObj.Value
						end
					end
				end
			end)
			if not ok then
				Library:Notification("Failed to get config, report this to the devs: " .. err, 5, Color3FromRGB(255, 0, 0))
			end;
			return HttpService:JSONEncode(config)
		end;
		function Library:LoadConfig(configJson)
			if not configJson then
				Library:Notification("Config not found, did you possibly delete a selected config and forget to unselect it?", 5, Color3FromRGB(255, 0, 0), nil)
				return
			end;
			local decoded = HttpService:JSONDecode(configJson)
			local ok, err = pcall(function()
				for flag, value in decoded do
					local flagObj = Library.Flags[flag]
					if flagObj then
						if flagObj.Class == "Keybind" then
							if table.find({
								"MouseButton1",
								"MouseWheel",
								"MouseButton2",
								"MouseButton3"
							}, value.Name) then
								flagObj:Set(value, true)
							else
								flagObj:Set(value)
							end
						elseif flagObj.Class == "Colorpicker" then
							flagObj:Set(value.Color, value.Alpha)
						else
							flagObj:Set(value)
						end
					end
				end
			end)
			if not ok then
				Library:Notification("Failed to load config, report this to the devs: " .. err, 5, Color3FromRGB(255, 0, 0))
			else
				Library:Notification("Successfully loaded config", 5, Color3FromRGB(0, 255, 0))
			end
		end;
		function Library:GetConfigsList(dropdownElement)
			local currentList = {}
			local newList = {}
			for _, filePath in listfiles(Library.Folders.Configs) do
				local name = string.gsub(filePath, Library.Folders.Directory .. "\\Configs\\", ""):gsub(".json", "")
				newList[#newList + 1] = name
			end;
			local changed = #newList ~= #currentList;
			if not changed then
				for i = 1, #newList do
					if newList[i] ~= currentList[i] then
						changed = true;
						break
					end
				end
			end;
			if changed then
				currentList = newList;
				dropdownElement:Refresh(currentList)
			end
		end;
		function Library:AddToTheme(wrapper, propertyMap)
			local entry = {
				Instance = wrapper.Object,
				Properties = propertyMap
			}
			for prop, value in entry.Properties do
				if type(value) == "string" then
					if Library.Theme[value] then
						entry.Instance[prop] = Library.Theme[value]
					end
				else
					entry.Instance[prop] = value()
				end
			end;
			table.insert(Library.ThemeInstances, entry)
			Library.ThemeMap[wrapper.Object] = entry
		end;
		function Library:ChangeObjectTheme(wrapper, propertyMap)
			if Library.ThemeMap[wrapper.Object] then
				local entry = Library.ThemeMap[wrapper.Object]
				entry.Properties = propertyMap;
				Library.ThemeMap[wrapper.Object] = entry
			end
		end;
		function Library:UpdateTheme(themeKey, color)
			Library.Theme[themeKey] = color;
			for instance, entry in Library.ThemeMap do
				for prop, value in entry.Properties do
					if value == themeKey then
						instance[prop] = color
					end
				end
			end
		end;
		function Library:NextFlag()
			local count = Library.UnnamedFlags + 1;
			return string.format("%s_%s_flag", count, HttpService:GenerateGUID(false))
		end;
		function Library:GetTransparencyPropertyFromType(instance)
			if instance:IsA("UIStroke") then
				return {
					"Transparency"
				}
			elseif instance:IsA("ImageLabel") then
				return {
					"ImageTransparency"
				}
			elseif instance:IsA("TextButton") or instance:IsA("TextBox") then
				return {
					"TextTransparency",
					"BackgroundTransparency"
				}
			elseif instance:IsA("Frame") or instance:IsA("ScrollingFrame") then
				return "BackgroundTransparency"
			elseif instance:IsA("TextLabel") then
				return {
					"TextTransparency"
				}
			end
		end;
		function Library:Floor(value, step)
			local mult = 1 / (step or 1)
			return math.floor(value * mult + 0.5) / mult
		end;
		function Library:Colorpicker(options)
			local colorpicker = {
				IsOpen = false,
				Hue = 0,
				Saturation = 0,
				Value = 0,
				Color = Color3.fromRGB(0, 0, 0),
				Hex = "",
				Alpha = 0,
				Class = "Colorpicker"
			}
			local elements = {}
			do
				elements["Colorbutton"] = InstanceUtil:Create("TextButton", {
					Parent = options.Parent.Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(0, 0, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					AnchorPoint = NewVector2(1, 0.5),
					Name = "\0",
					Position = NewUDim2(1, 0, 0, 0),
					Size = NewUDim2(0, 23, 0, 13),
					BorderSizePixel = 0,
					TextSize = 14,
					BackgroundColor3 = Color3FromRGB(131, 194, 242)
				})
				elements["Colorbutton"]:Border():AddHoverEffect()
				InstanceUtil:Create("UIGradient", {
					Parent = elements["Colorbutton"].Object,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3FromRGB(86, 86, 86))
					}
				})
				local function getColorButtonPosition(index)
					local cols = 5;
					local col = math.floor(index / cols)
					local row = index % cols;
					local btnSize = elements["Colorbutton"].Object.AbsoluteSize;
					local spacing = 4;
					local xOffset = (btnSize.X + spacing) * row - spacing;
					return NewUDim2(1, -xOffset + 23, 0.5, 0)
				end;
				elements["Colorbutton"].Object.Position = getColorButtonPosition(options.Count)
				elements["ColorpickerWindow"] = InstanceUtil:Create("Frame", {
					Parent = Library.Holder.Object,
					Name = "\0",
					Position = NewUDim2(0, 0, 0, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Size = NewUDim2(0, 194, 0, 163),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(13, 13, 13)
				})
				elements["ColorpickerWindow"]:AddToTheme({
					BackgroundColor3 = "Background"
				})
				elements["ColorpickerWindow"]:Border()
				elements["ColorpickerWindow"]:MakeResizeable(NewVector2(165, 145), NewVector2(9999, 9999))
				elements["ColorpickerWindow"]:MakeDraggable()
				elements["Shadow"] = InstanceUtil:Create("ImageLabel", {
					Parent = elements["ColorpickerWindow"].Object,
					ImageColor3 = Color3FromRGB(131, 194, 242),
					ImageTransparency = 0.43,
					AnchorPoint = NewVector2(0.5, 0.5),
					Image = "rbxassetid://112971167999062",
					ZIndex = -1,
					BorderSizePixel = 0,
					SliceCenter = NewRect(NewVector2(112, 112), NewVector2(147, 147)),
					ScaleType = Enum.ScaleType.Slice,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					Position = NewUDim2(0.5, 0, 0.5, 0),
					SliceScale = 0.6,
					Name = "Shadow",
					Size = NewUDim2(1, 55, 1, 55),
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Shadow"]:AddToTheme({
					ImageColor3 = "Accent"
				})
				InstanceUtil:Create("UIPadding", {
					Parent = elements["ColorpickerWindow"].Object,
					PaddingTop = NewUDim(0, 5),
					PaddingBottom = NewUDim(0, 5),
					PaddingRight = NewUDim(0, 5),
					PaddingLeft = NewUDim(0, 5)
				})
				elements["Hue"] = InstanceUtil:Create("ImageButton", {
					Parent = elements["ColorpickerWindow"].Object,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					AnchorPoint = NewVector2(1, 0),
					Image = "rbxassetid://133334110106525",
					Name = "\0",
					Position = NewUDim2(1, 0, 0, 0),
					Size = NewUDim2(0, 13, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Hue"]:Border()
				elements["HueDragger"] = InstanceUtil:Create("Frame", {
					Parent = elements["Hue"].Object,
					Name = "\0",
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Size = NewUDim2(1, 0, 0, 1),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["HueDragger"]:Border()
				elements["Alpha"] = InstanceUtil:Create("TextButton", {
					Parent = elements["ColorpickerWindow"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(0, 0, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					AnchorPoint = NewVector2(0, 1),
					Name = "\0",
					Position = NewUDim2(0, 0, 1, 0),
					Size = NewUDim2(1, -17, 0, 13),
					BorderSizePixel = 0,
					TextSize = 14,
					BackgroundColor3 = Color3FromRGB(255, 0, 0)
				})
				elements["Alpha"]:Border()
				elements["Checkers"] = InstanceUtil:Create("ImageLabel", {
					Parent = elements["Alpha"].Object,
					ScaleType = Enum.ScaleType.Tile,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Name = "\0",
					Image = "http://www.roblox.com/asset/?id=18274452449",
					BackgroundTransparency = 1,
					Size = NewUDim2(1, 0, 1, 0),
					TileSize = NewUDim2(0, 6, 0, 6),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				InstanceUtil:Create("UIGradient", {
					Parent = elements["Checkers"].Object,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(1, 0)
					}
				})
				elements["AlphaDragger"] = InstanceUtil:Create("Frame", {
					Parent = elements["Alpha"].Object,
					Name = "\0",
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Size = NewUDim2(0, 1, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["AlphaDragger"]:Border()
				elements["Palette"] = InstanceUtil:Create("TextButton", {
					Parent = elements["ColorpickerWindow"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(0, 0, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Name = "\0",
					Size = NewUDim2(1, -17, 1, -17),
					BorderSizePixel = 0,
					TextSize = 14,
					BackgroundColor3 = Color3FromRGB(255, 0, 0)
				})
				elements["Saturation"] = InstanceUtil:Create("ImageLabel", {
					Parent = elements["Palette"].Object,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Image = "rbxassetid://130624743341203",
					BackgroundTransparency = 1,
					Name = "\0",
					Size = NewUDim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Value"] = InstanceUtil:Create("ImageLabel", {
					Parent = elements["Palette"].Object,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Image = "rbxassetid://96192970265863",
					BackgroundTransparency = 1,
					Name = "\0",
					Size = NewUDim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Palette"]:Border()
				elements["PaletteDragger"] = InstanceUtil:Create("Frame", {
					Parent = elements["Palette"].Object,
					Name = "\0",
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Size = NewUDim2(0, 2, 0, 2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["PaletteDragger"]:Border()
			end;
			local isDraggingPalette = false;
			local isDraggingHue = false;
			local isDraggingAlpha = false;
			elements["ColorpickerWindow"].Object.BackgroundTransparency = 1;
			for _, child in elements["ColorpickerWindow"].Object:GetDescendants() do
				if child:IsA("Frame") or child:IsA("TextButton") then
					child.BackgroundTransparency = 1
				elseif child:IsA("ImageLabel") or child:IsA("ImageButton") then
					child.ImageTransparency = 1;
					child.BackgroundTransparency = 1
				elseif child:IsA("TextLabel") or child:IsA("TextBox") then
					child.TextTransparency = 1
				elseif child:IsA("UIStroke") then
					child.Transparency = 1
				end
			end;
			function colorpicker:Update(skipAlphaSync)
				local h, s, v = colorpicker.Hue, colorpicker.Saturation, colorpicker.Value;
				colorpicker.Color = Color3FromHSV(h, s, v)
				colorpicker.Hex = colorpicker.Color:ToHex()
				elements["Colorbutton"]:Tween(nil, {
					BackgroundColor3 = colorpicker.Color
				})
				elements["Palette"]:Tween(nil, {
					BackgroundColor3 = Color3FromHSV(h, 1, 1)
				})
				if not skipAlphaSync then
					elements["Alpha"]:Tween(nil, {
						BackgroundColor3 = colorpicker.Color
					})
				end;
				if options.Callback then
					pcall(options.Callback, colorpicker.Color, colorpicker.Alpha)
				end
			end;
			function colorpicker:SetOpen(forceState)
				colorpicker.IsOpen = forceState or not colorpicker.IsOpen;
				elements["ColorpickerWindow"].Object.Position = NewUDim2(0, elements["Colorbutton"].Object.AbsolutePosition.X, 0, elements["Colorbutton"].Object.AbsolutePosition.Y + 12)
				if colorpicker.IsOpen then
					elements["ColorpickerWindow"].Object.Visible = true;
					elements["ColorpickerWindow"].Object.ZIndex = 15;
					elements["ColorpickerWindow"]:Tween(nil, {
						BackgroundTransparency = 0
					})
					for _, child in elements["ColorpickerWindow"].Object:GetDescendants() do
						if not child.ClassName:find("UI") and not child.Name:find("Shadow") then
							child.ZIndex = 15
						end;
						if child:IsA("Frame") or child:IsA("TextButton") then
							TweenUtil:Create(child, nil, {
								BackgroundTransparency = 0
							}, true)
						elseif child:IsA("ImageLabel") or child:IsA("ImageButton") then
							TweenUtil:Create(child, nil, {
								ImageTransparency = 0
							}, true)
						elseif child:IsA("TextLabel") or child:IsA("TextBox") then
							TweenUtil:Create(child, nil, {
								TextTransparency = 0
							}, true)
						elseif child:IsA("UIStroke") then
							TweenUtil:Create(child, nil, {
								Transparency = 0
							}, true)
						end
					end
				else
					for _, child in elements["ColorpickerWindow"].Object:GetDescendants() do
						if not child.ClassName:find("UI") and not child.Name:find("Shadow") then
							child.ZIndex = 1
						end;
						if child:IsA("Frame") or child:IsA("TextButton") then
							TweenUtil:Create(child, nil, {
								BackgroundTransparency = 1
							}, true)
						elseif child:IsA("ImageLabel") or child:IsA("ImageButton") then
							TweenUtil:Create(child, nil, {
								ImageTransparency = 1
							}, true)
						elseif child:IsA("TextLabel") or child:IsA("TextBox") then
							TweenUtil:Create(child, nil, {
								TextTransparency = 1
							}, true)
						elseif child:IsA("UIStroke") then
							TweenUtil:Create(child, nil, {
								Transparency = 1
							}, true)
						end
					end;
					elements["ColorpickerWindow"]:Tween(nil, {
						BackgroundTransparency = 1
					})
					task.wait(0.1)
					elements["ColorpickerWindow"].Object.Visible = false;
					elements["ColorpickerWindow"].Object.ZIndex = 1
				end
			end;
			function colorpicker:Set(color, alpha)
				if type(color) == "table" then
					color = Color3FromRGB(color[1], color[2], color[3])
					alpha = color[4]
				elseif type(color) == "string" then
					color = Color3FromHex(color)
				end;
				colorpicker.Hue, colorpicker.Saturation, colorpicker.Value = color:ToHSV()
				colorpicker.Color = color;
				colorpicker.Hex = color:ToHex()
				colorpicker.Alpha = alpha or 0;
				local satX = math.clamp(1 - self.Saturation, 0, 1)
				local valY = math.clamp(1 - self.Value, 0, 1)
				elements["PaletteDragger"].Object.Position = NewUDim2(satX, 0, valY, 0)
				local hueY = math.clamp(self.Hue, 0, 0.985)
				elements["HueDragger"].Object.Position = NewUDim2(0, 0, hueY, 0)
				local alphaX = math.clamp(self.Alpha, 0, 0.985)
				elements["AlphaDragger"].Object.Position = NewUDim2(0, 0, alphaX, 0)
				colorpicker:Update()
			end;
			function colorpicker:SlidePalette(input)
				if not isDraggingPalette then
					return
				end;
				local palette = elements["Palette"].Object;
				local relX = math.clamp((input.Position.X - palette.AbsolutePosition.X) / palette.AbsoluteSize.X, 0, 1)
				local relY = math.clamp((input.Position.Y - palette.AbsolutePosition.Y) / palette.AbsoluteSize.Y, 0, 1)
				colorpicker.Saturation = math.clamp(1 - relX, 0, 1)
				colorpicker.Value = math.clamp(1 - relY, 0, 1)
				elements["PaletteDragger"]:Tween(nil, {
					Position = NewUDim2(math.clamp(relX, 0, 0.987), 0, math.clamp(relY, 0, 0.985), 0)
				})
				colorpicker:Update()
			end;
			function colorpicker:SlideHue(input)
				if not isDraggingHue then
					return
				end;
				local hue = elements["Hue"].Object;
				local relY = math.clamp((input.Position.Y - hue.AbsolutePosition.Y) / hue.AbsoluteSize.Y, 0, 1)
				colorpicker.Hue = relY;
				elements["HueDragger"]:Tween(nil, {
					Position = NewUDim2(0, 0, math.clamp(relY, 0, 0.985), 0)
				})
				colorpicker:Update()
			end;
			function colorpicker:SlideAlpha(input)
				if not isDraggingAlpha then
					return
				end;
				local alphaBar = elements["Alpha"].Object;
				local relX = math.clamp((input.Position.X - alphaBar.AbsolutePosition.X) / alphaBar.AbsoluteSize.X, 0, 1)
				colorpicker.Alpha = relX;
				elements["AlphaDragger"]:Tween(nil, {
					Position = NewUDim2(math.clamp(relX, 0, 0.987), 0, 0, 0)
				})
				colorpicker:Update(true)
			end;
			function colorpicker:Get()
				return colorpicker.Color
			end;
			function colorpicker:GetAlpha()
				return colorpicker.Alpha
			end;
			function colorpicker:SetVisiblity(visible)
				elements["Colorbutton"].Object.Visible = visible
			end;
			elements["Colorbutton"]:Connect("MouseButton1Click", function()
				colorpicker:SetOpen(not colorpicker.IsOpen)
			end, options.Name .. " Open Event")
			elements["Palette"]:Connect("InputBegan", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDraggingPalette = true;
					colorpicker:SlidePalette(input)
				end
			end, options.Name .. " Palette Input Began")
			elements["Palette"]:Connect("InputEnded", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDraggingPalette = false
				end
			end, options.Name .. " Palette Input Ended")
			elements["Hue"]:Connect("InputBegan", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDraggingHue = true;
					colorpicker:SlideHue(input)
				end
			end, options.Name .. " Hue Input Began")
			elements["Hue"]:Connect("InputEnded", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDraggingHue = false
				end
			end, options.Name .. " Hue Input Ended")
			elements["Alpha"]:Connect("InputBegan", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDraggingAlpha = true;
					colorpicker:SlideAlpha(input)
				end
			end, options.Name .. " Alpha Input Began")
			elements["Alpha"]:Connect("InputEnded", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDraggingAlpha = false
				end
			end, options.Name .. " Alpha Input Ended")
			Library:Connect(UserInputService.InputChanged, function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					if isDraggingPalette then
						colorpicker:SlidePalette(input)
					end;
					if isDraggingHue then
						colorpicker:SlideHue(input)
					end;
					if isDraggingAlpha then
						colorpicker:SlideAlpha(input)
					end
				end
			end, options.Name .. " Palette Input Changed")
			if options.Default then
				colorpicker:Set(options.Default, options.Alpha)
			end;
			return colorpicker
		end;
		function Library:Keybind(options)
			local keybind = {
				IsOpen = false,
				Key = nil,
				Mode = "",
				State = false,
				Class = "Keybind"
			}
			local keyListEntry = Library.KeyList:AddNewKey("None", "None")
			local elements = {}
			do
				elements["Key"] = InstanceUtil:Create("TextButton", {
					Parent = options.Parent.Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(0, 0, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					AnchorPoint = NewVector2(1, 0),
					Size = NewUDim2(0, 0, 1, 0),
					Name = "\0",
					Position = NewUDim2(1, 0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 14,
					BackgroundColor3 = Color3FromRGB(15, 15, 15)
				})
				elements["Key"]:AddToTheme({
					BackgroundColor3 = "Element"
				})
				elements["Key"]:Border():AddHoverEffect()
				InstanceUtil:Create("UIPadding", {
					Parent = elements["Key"].Object,
					PaddingRight = NewUDim(0, 4),
					PaddingLeft = NewUDim(0, 3)
				})
				elements["Value"] = InstanceUtil:Create("TextLabel", {
					Parent = elements["Key"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(229, 229, 229),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "None",
					Name = "\0",
					BackgroundTransparency = 1,
					Size = NewUDim2(0, 0, 1, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Value"]:AddToTheme({
					TextColor3 = "Text"
				})
				elements["Value"]:TextBorder()
				InstanceUtil:Create("UIGradient", {
					Parent = elements["Key"].Object,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.041, Color3FromRGB(189, 189, 189)),
						ColorSequenceKeypoint.new(0.315, Color3FromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3FromRGB(255, 255, 255))
					}
				})
				elements["Window"] = InstanceUtil:Create("Frame", {
					Parent = elements["Key"].Object,
					Visible = false,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					AnchorPoint = NewVector2(1, 0),
					Name = "\0",
					Position = NewUDim2(1, 0, 1, 4),
					Size = NewUDim2(0, 60, 0, 52),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(16, 16, 16)
				})
				elements["Window"]:AddToTheme({
					BackgroundColor3 = "Inline"
				})
				elements["Window"]:Border()
				InstanceUtil:Create("UIGradient", {
					Parent = elements["Window"].Object,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.041, Color3FromRGB(189, 189, 189)),
						ColorSequenceKeypoint.new(0.315, Color3FromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3FromRGB(255, 255, 255))
					}
				})
				elements["Toggle"] = InstanceUtil:Create("TextButton", {
					Parent = elements["Window"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(131, 194, 242),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "Toggle",
					AutoButtonColor = false,
					Name = "\0",
					BackgroundTransparency = 1,
					Position = NewUDim2(0, 0, 0, 2),
					Size = NewUDim2(1, 0, 0, 15),
					BorderSizePixel = 0,
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Toggle"]:AddToTheme({
					TextColor3 = "Text"
				})
				elements["Toggle"]:TextBorder()
				elements["Hold"] = InstanceUtil:Create("TextButton", {
					Parent = elements["Window"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(229, 229, 229),
					TextTransparency = 0.28,
					Text = "Hold",
					AutoButtonColor = false,
					Name = "\0",
					Size = NewUDim2(1, 0, 0, 15),
					BackgroundTransparency = 1,
					Position = NewUDim2(0, 0, 0, 17),
					BorderSizePixel = 0,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Hold"]:AddToTheme({
					TextColor3 = "Text"
				})
				elements["Hold"]:TextBorder()
				elements["Always"] = InstanceUtil:Create("TextButton", {
					Parent = elements["Window"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(229, 229, 229),
					TextTransparency = 0.28,
					Text = "Always",
					AutoButtonColor = false,
					Name = "\0",
					Size = NewUDim2(1, 0, 0, 15),
					BackgroundTransparency = 1,
					Position = NewUDim2(0, 0, 0, 34),
					BorderSizePixel = 0,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Always"]:AddToTheme({
					TextColor3 = "Text"
				})
				elements["Always"]:TextBorder()
			end;
			local isPickingKey = false;
			function keybind:Get()
				return keybind.State
			end;
			function keybind:GetKey()
				return keybind.Key
			end;
			function keybind:SetVisiblity(visible)
				elements["Key"].Object.Visible = visible
			end;
			function keybind:SetOpen(state)
				keybind.IsOpen = state;
				elements["Window"].Object.ZIndex = state and 15 or 1;
				if keybind.IsOpen then
					elements["Window"].Object.Visible = true;
					elements["Window"]:Tween(nil, {
						BackgroundTransparency = 0
					})
					task.wait(0.06)
					for _, child in elements["Window"].Object:GetDescendants() do
						if child:IsA("TextButton") then
							TweenUtil:Create(child, nil, {
								TextTransparency = 0
							}, true)
						elseif child:IsA("UIStroke") then
							TweenUtil:Create(child, nil, {
								Transparency = 0
							}, true)
						end;
						if not child.ClassName:find("UI") then
							child.ZIndex = 15
						end
					end
				else
					for _, child in elements["Window"].Object:GetDescendants() do
						if child:IsA("TextButton") then
							TweenUtil:Create(child, nil, {
								TextTransparency = 1
							}, true)
						elseif child:IsA("UIStroke") then
							TweenUtil:Create(child, nil, {
								Transparency = 1
							}, true)
						end;
						if not child.ClassName:find("UI") then
							child.ZIndex = 1
						end
					end;
					task.wait(0.06)
					elements["Window"]:Tween(nil, {
						BackgroundTransparency = 1
					})
					task.wait(0.05)
					elements["Window"].Object.Visible = false
				end
			end;
			function keybind:SetMode(mode)
				keybind.Mode = mode;
				local function highlight(btn, isActive)
					local color = isActive and Library.Theme.Accent or Library.Theme.Text;
					local themeKey = isActive and "Accent" or "Text"
					elements[btn]:Tween(nil, {
						TextColor3 = color
					})
					Library:ChangeObjectTheme(elements[btn], {
						TextColor3 = themeKey
					})
				end;
				highlight("Toggle", mode == "Toggle")
				highlight("Hold", mode == "Hold")
				highlight("Always", mode == "Always")
				if mode == "Always" then
					keybind.State = true
				end;
				if keybind.Key then
					keyListEntry:Set(keybind.Key, options.Name)
				end
			end;
			function keybind:Press(isDown)
				if keybind.Mode == "Always" then
					keybind.State = true
				elseif keybind.Mode == "Once" then
					keybind.State = true;
					task.wait(0.1)
					keybind.State = false
				elseif keybind.Mode == "Hold" then
					keybind.State = isDown
				elseif keybind.Mode == "Toggle" then
					keybind.State = not keybind.State
				end;
				if keybind.Key then
					keyListEntry:SetStatus(keybind.State)
				end;
				if options.Callback then
					pcall(options.Callback, keybind.State)
				end
			end;
			function keybind:Set(keyInput, isMouse)
				if isMouse then
					if type(keyInput) == "table" then
						keyInput = Enum.UserInputType[keyInput.Name]
					end;
					isPickingKey = true;
					local label = KeyNames[keyInput] or string.sub(keyInput.Name, 1, 2)
					keybind.Key = keyInput;
					elements["Value"].Object.Text = label;
					elements["Value"]:Tween(nil, {
						TextColor3 = Library.Theme.Text
					})
					elements["Value"]:ChangeObjectTheme({
						TextColor3 = "Text"
					})
					isPickingKey = false
				else
					if keyInput and (type(keyInput) == "table" or typeof(keyInput) == "EnumItem") and keyInput.Name then
						isPickingKey = true;
						if KeyNames[keyInput.Name] then
							elements["Value"].Object.Text = KeyNames[keyInput.Name]
							keybind.Key = KeyNames[keyInput.Name]
						else
							elements["Value"].Object.Text = keyInput.Name:sub(1, 2)
							keybind.Key = keyInput.Name:sub(1, 2)
						end;
						if type(keyInput) == "table" and keyInput.Name ~= "" then
							keybind.Key = Enum.KeyCode[keyInput.Name]
						else
							keybind.Key = keyInput
						end;
						elements["Value"]:Tween(nil, {
							TextColor3 = Library.Theme.Text
						})
						elements["Value"]:ChangeObjectTheme({
							TextColor3 = "Text"
						})
						isPickingKey = false
					end
				end;
				if keybind.Key then
					keyListEntry:Set(keybind.Key, options.Name)
				end
			end;
			elements["Key"]:Connect("MouseButton2Down", function()
				keybind:SetOpen(not keybind.IsOpen)
			end, options.Name .. " Open Event")
			elements["Key"]:Connect("MouseButton1Click", function()
				isPickingKey = true;
				elements["Value"]:Tween(nil, {
					TextColor3 = Library.Theme.Accent
				})
				elements["Value"]:ChangeObjectTheme({
					TextColor3 = "Accent"
				})
				UserInputService.InputBegan:Connect(function(input)
					if isPickingKey then
						if input.UserInputType == Enum.UserInputType.Keyboard then
							keybind:Set(input.KeyCode)
						elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
							keybind:Set(Enum.UserInputType.MouseButton1, true)
						elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
							keybind:Set(Enum.UserInputType.MouseButton2, true)
						elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
							keybind:Set(Enum.UserInputType.MouseButton3, true)
						elseif input.UserInputType == Enum.UserInputType.MouseWheel then
							keybind:Set(Enum.UserInputType.MouseWheel, true)
						else
							isPickingKey = false
						end
					end
				end)
			end, options.Name .. " Pick Event")
			Library:Connect(UserInputService.InputBegan, function(input)
				if not isPickingKey then
					if input.KeyCode == keybind.Key or input.UserInputType == keybind.Key then
						if keybind.Mode == "Toggle" then
							keybind:Press()
						elseif keybind.Mode == "Hold" then
							keybind:Press(true)
						end
					end
				end
			end, options.Name .. " Input Began")
			Library:Connect(UserInputService.InputEnded, function(input)
				if not isPickingKey then
					if input.KeyCode == keybind.Key or input.UserInputType == keybind.Key then
						if keybind.Mode == "Hold" then
							keybind:Press(false)
						end
					end
				end
			end, options.Name .. " Input Ended")
			elements["Toggle"]:Connect("MouseButton1Down", function()
				keybind:SetMode("Toggle")
			end, options.Name .. " Toggle Event")
			elements["Hold"]:Connect("MouseButton1Down", function()
				keybind:SetMode("Hold")
			end, options.Name .. " Hold Event")
			elements["Always"]:Connect("MouseButton1Down", function()
				keybind:SetMode("Always")
				keybind:Press(true)
			end, options.Name .. " Always Event")
			if options.Default then
				keybind:Set(options.Default)
			end;
			return keybind
		end;
		function Library:Watermark(text)
			local watermark = {}
			local elements = {}
			elements["Watermark"] = InstanceUtil:Create("Frame", {
				Parent = Library.Holder.Object,
				BorderColor3 = Color3FromRGB(0, 0, 0),
				AnchorPoint = NewVector2(0.5, 0),
				Name = "\0",
				Position = NewUDim2(0.5, 0, 0, 15),
				Size = NewUDim2(0, 0, 0, 20),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = Color3FromRGB(13, 13, 13)
			})
			elements["Watermark"]:AddToTheme({
				BackgroundColor3 = "Background"
			})
			elements["Watermark"]:Border()
			elements["Watermark"]:MakeDraggable()
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Watermark"].Object,
				PaddingRight = NewUDim(0, 5),
				PaddingLeft = NewUDim(0, 5)
			})
			elements["Title"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Watermark"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = text,
				Name = "\0",
				Size = NewUDim2(1, 0, 1, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Title"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Title"]:TextBorder()
			elements["Liner"] = InstanceUtil:Create("Frame", {
				Parent = elements["Watermark"].Object,
				AnchorPoint = NewVector2(0, 1),
				Name = "\0",
				Position = NewUDim2(0, -5, 1, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 10, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(131, 194, 242)
			})
			elements["Liner"]:AddToTheme({
				BackgroundColor3 = "Accent"
			})
			function watermark:SetVisiblity(visible)
				elements["Watermark"].Object.Visible = visible
			end;
			return watermark
		end;
		function Library:Notification(message, duration, color)
			local elements = {}
			elements["Notification"] = InstanceUtil:Create("Frame", {
				Parent = Library.NotifHolder.Object,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 21),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = Color3FromRGB(13, 13, 13)
			})
			elements["Notification"]:AddToTheme({
				BackgroundColor3 = "Background"
			})
			elements["Notification"]:Border()
			elements["Title"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Notification"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = message,
				Position = NewUDim2(0, 0, 0, -1),
				Name = "\0",
				Size = NewUDim2(1, 0, 1, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Title"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Title"]:TextBorder()
			elements["Liner"] = InstanceUtil:Create("Frame", {
				Parent = elements["Notification"].Object,
				AnchorPoint = NewVector2(0, 1),
				Name = "\0",
				Position = NewUDim2(0, -5, 1, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 10, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = color
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Notification"].Object,
				PaddingRight = NewUDim(0, 5),
				PaddingLeft = NewUDim(0, 5)
			})
			elements["Notification"].Object.BackgroundTransparency = 1;
			for _, child in elements["Notification"].Object:GetDescendants() do
				if child:IsA("TextLabel") then
					child.TextTransparency = 1
				elseif child:IsA("ImageLabel") then
					child.ImageTransparency = 1
				elseif child:IsA("UIStroke") then
					child.Transparency = 1
				elseif child:IsA("Frame") then
					child.BackgroundTransparency = 1
				end
			end;
			task.spawn(function()
				elements["Notification"]:Tween(nil, {
					BackgroundTransparency = 0
				})
				task.wait(0.08)
				for _, child in elements["Notification"].Object:GetDescendants() do
					if child:IsA("TextLabel") then
						TweenUtil:Create(child, nil, {
							TextTransparency = 0
						}, true)
					elseif child:IsA("ImageLabel") then
						TweenUtil:Create(child, nil, {
							ImageTransparency = 0
						}, true)
					elseif child:IsA("UIStroke") then
						TweenUtil:Create(child, nil, {
							Transparency = 0
						}, true)
					elseif child:IsA("Frame") then
						TweenUtil:Create(child, nil, {
							BackgroundTransparency = 0
						}, true)
					end
				end;
				task.delay(duration + 0.1, function()
					for _, child in elements["Notification"].Object:GetDescendants() do
						if child:IsA("TextLabel") then
							TweenUtil:Create(child, nil, {
								TextTransparency = 1
							}, true)
						elseif child:IsA("ImageLabel") then
							TweenUtil:Create(child, nil, {
								ImageTransparency = 1
							}, true)
						elseif child:IsA("UIStroke") then
							TweenUtil:Create(child, nil, {
								Transparency = 1
							}, true)
						elseif child:IsA("Frame") then
							TweenUtil:Create(child, nil, {
								BackgroundTransparency = 1
							}, true)
						end
					end;
					task.wait(0.08)
					elements["Notification"]:Tween(nil, {
						BackgroundTransparency = 1
					})
					task.wait(0.2)
					elements["Notification"]:Clean()
				end)
			end)
		end;
		function Library:KeybindList()
			local keyList = {}
			Library.KeyList = keyList;
			local elements = {}
			elements["KeybindsList"] = InstanceUtil:Create("Frame", {
				Parent = Library.Holder.Object,
				AnchorPoint = NewVector2(0, 0.5),
				Name = "\0",
				Position = NewUDim2(0, 15, 0.5, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3FromRGB(13, 13, 13)
			})
			elements["KeybindsList"]:AddToTheme({
				BackgroundColor3 = "Background"
			})
			elements["KeybindsList"]:Border()
			elements["KeybindsList"]:MakeDraggable()
			elements["Title"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["KeybindsList"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "Keybinds",
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 15),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Title"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Title"]:TextBorder()
			InstanceUtil:Create("UIPadding", {
				Parent = elements["KeybindsList"].Object,
				PaddingTop = NewUDim(0, 5),
				PaddingBottom = NewUDim(0, 5),
				PaddingRight = NewUDim(0, 5),
				PaddingLeft = NewUDim(0, 5)
			})
			elements["Content"] = InstanceUtil:Create("Frame", {
				Parent = elements["KeybindsList"].Object,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(0, 0, 0, 18),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["Content"].Object,
				Padding = NewUDim(0, 3),
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Content"].Object,
				PaddingRight = NewUDim(0, 5),
				PaddingLeft = NewUDim(0, 5)
			})
			function keyList:AddNewKey(keyDisplay, name)
				local displayName = KeyNames[keyDisplay]
				if not KeyNames[keyDisplay] then
					keyDisplay = tostring(keyDisplay):sub(1, 2)
				end;
				local label = InstanceUtil:Create("TextLabel", {
					Parent = elements["Content"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(240, 240, 240),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "553633228",
					Name = "\0",
					Size = NewUDim2(0, 0, 0, 15),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				Library:AddToTheme(label, {
					TextColor3 = "Text"
				})
				label:TextBorder()
				local entry = {
					Text = label,
					Key = keyDisplay,
					RealKey = displayName,
					Name = name,
					IsActive = false
				}
				function entry:SetStatus(active)
					entry.IsActive = active;
					label:Tween(nil, {
						TextColor3 = active and Library.Theme.Accent or Library.Theme.Text
					})
					Library:ChangeObjectTheme(label, {
						TextColor3 = active and "Accent" or "Text"
					})
				end;
				function entry:Set(key, _)
					local display = KeyNames[key]
					if not KeyNames[key] then
						key = tostring(key):sub(1, 2)
					end;
					label.Object.Text = "553633228"
				end;
				return entry
			end;
			function keyList:SetVisiblity(visible)
				elements["KeybindsList"].Object.Visible = visible or true
			end;
			return keyList
		end;
		function Library:Window(options)
			options = options or {}
			local window = {
				Name = options.Name or options.name or "Window",
				Size = options.Size or options.size or NewUDim2(0, 622, 0, 453),
				FadeSpeed = options.FadeSpeed or options.fadespeed or 0.2,
				Icon = options.Icon or options.icon or nil,
				TransparencyCache = {},
				IsOpen = true,
				Pages = {},
				SubPages = {},
				Sections = {},
				Elements = {}
			}
			local elements = {}
			elements["MainFrame"] = InstanceUtil:Create("Frame", {
				Parent = Library.Holder.Object,
				Name = "\0",
				Position = NewUDim2(0, Camera.ViewportSize.X / 3, 0, Camera.ViewportSize.Y / 3),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = window.Size,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(13, 13, 13)
			})
			elements["MainFrame"]:AddToTheme({
				BackgroundColor3 = "Background"
			})
			elements["MainFrame"]:MakeDraggable()
			elements["MainFrame"]:Border()
			elements["MainFrame"]:MakeResizeable(NewVector2(window.Size.X.Offset, window.Size.Y.Offset), NewVector2(9999, 9999))
			elements["Shadow"] = InstanceUtil:Create("ImageLabel", {
				Parent = elements["MainFrame"].Object,
				ImageColor3 = Color3FromRGB(131, 194, 242),
				ImageTransparency = 0.43,
				AnchorPoint = NewVector2(0.5, 0.5),
				Image = "rbxassetid://112971167999062",
				ZIndex = -1,
				BorderSizePixel = 0,
				SliceCenter = NewRect(NewVector2(112, 112), NewVector2(147, 147)),
				ScaleType = Enum.ScaleType.Slice,
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Position = NewUDim2(0.5, 0, 0.5, 0),
				SliceScale = 0.6,
				Name = "\0",
				Size = NewUDim2(1, 55, 1, 55),
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Shadow"]:AddToTheme({
				ImageColor3 = "Accent"
			})
			elements["Inline"] = InstanceUtil:Create("Frame", {
				Parent = elements["MainFrame"].Object,
				Name = "\0",
				Position = NewUDim2(0, 6, 0, 36),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -12, 1, -42),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(16, 16, 16)
			})
			elements["Inline"]:AddToTheme({
				BackgroundColor3 = "Inline"
			})
			elements["Inline"]:Border()
			elements["Topbar"] = InstanceUtil:Create("Frame", {
				Parent = elements["MainFrame"].Object,
				Name = "\0",
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, 30),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(25, 25, 25)
			})
			elements["Topbar"]:AddToTheme({
				BackgroundColor3 = "Background"
			})
			elements["Title"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Topbar"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = window.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 15),
				AnchorPoint = NewVector2(0, 0.5),
				Position = NewUDim2(0, 3, 0.5, 2),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Title"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Title"]:TextBorder()
			elements["Liner"] = InstanceUtil:Create("Frame", {
				Parent = elements["Title"].Object,
				AnchorPoint = NewVector2(1, 0),
				Name = "\0",
				Position = NewUDim2(1, 12, 0, -10),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(0, 1, 1, 15),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(34, 34, 34)
			})
			elements["Liner"]:AddToTheme({
				BackgroundColor3 = "Border"
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Title"].Object,
				PaddingLeft = NewUDim(0, 5)
			})
			if window.Icon then
				elements["Icon"] = InstanceUtil:Create("ImageLabel", {
					Parent = elements["Topbar"].Object,
					Visible = false,
					ScaleType = Enum.ScaleType.Fit,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Image = window.Icon,
					BackgroundTransparency = 1,
					Name = "\0",
					Size = NewUDim2(0, 28, 0, 28),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				elements["Title"].Object.Position = NewUDim2(0, 30, 0.5, 2)
			end;
			elements["Liner2"] = InstanceUtil:Create("Frame", {
				Parent = elements["Topbar"].Object,
				AnchorPoint = NewVector2(0, 1),
				Name = "\0",
				Position = NewUDim2(0, 0, 1, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(34, 34, 34)
			})
			elements["Liner2"]:AddToTheme({
				BackgroundColor3 = "Border"
			})
			elements["Pages"] = InstanceUtil:Create("Frame", {
				Parent = elements["Topbar"].Object,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(0, elements["Title"].Object.TextBounds.X + 22, 0, 5),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -(elements["Title"].Object.TextBounds.X + 22), 1, -9),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["Pages"].Object,
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalFlex = Enum.UIFlexAlignment.Fill,
				Padding = NewUDim(0, 5),
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			elements["Pages"].Object.Position = NewUDim2(0, elements["Title"].Object.TextBounds.X + 22, 0, 5)
			elements["Pages"].Object.Size = NewUDim2(1, -(elements["Title"].Object.TextBounds.X + 22), 1, -9)
			function window:SetTitle(title)
				elements["Title"].Object.Text = title;
				local offset = elements["Title"].Object.TextBounds.X + 22;
				elements["Pages"].Object.Position = NewUDim2(0, offset, 0, 5)
				elements["Pages"].Object.Size = NewUDim2(1, -offset, 1, -9)
			end;
			function window:AddToTransparencyCache(index, value)
				if not window.TransparencyCache[index] then
					window.TransparencyCache[index] = value
				end
			end;
			function window:SetOpen(forceState)
				window.IsOpen = forceState or not window.IsOpen;
				if not window.IsOpen then
					for i, child in elements["MainFrame"].Object:GetDescendants() do
						if child:IsA("TextButton") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								TextTransparency = 1,
								BackgroundTransparency = 1
							}, true)
							window:AddToTransparencyCache(i, child.BackgroundTransparency)
						elseif child:IsA("ImageLabel") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								ImageTransparency = 1
							}, true)
							window:AddToTransparencyCache(i, child.ImageTransparency)
						elseif child:IsA("Frame") or child:IsA("ScrollingFrame") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								BackgroundTransparency = 1
							}, true)
							window:AddToTransparencyCache(i, child.BackgroundTransparency)
						elseif child:IsA("UIStroke") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								Transparency = 1
							}, true)
							window:AddToTransparencyCache(i, child.Transparency)
						elseif child:IsA("TextLabel") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								TextTransparency = 1
							}, true)
							window:AddToTransparencyCache(i, child.TextTransparency)
						end
					end;
					task.wait(0.1)
					elements["MainFrame"]:Tween(TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
						BackgroundTransparency = 1
					})
				else
					elements["MainFrame"]:Tween(TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
						BackgroundTransparency = 0
					})
					task.wait(0.1)
					for i, child in elements["MainFrame"].Object:GetDescendants() do
						if not window.TransparencyCache[i] then
							continue
						end;
						if child:IsA("TextButton") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								TextTransparency = 0,
								BackgroundTransparency = window.TransparencyCache[i]
							}, true)
						elseif child:IsA("ImageLabel") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								ImageTransparency = window.TransparencyCache[i]
							}, true)
						elseif child:IsA("Frame") or child:IsA("ScrollingFrame") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								BackgroundTransparency = window.TransparencyCache[i]
							}, true)
						elseif child:IsA("UIStroke") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								Transparency = window.TransparencyCache[i]
							}, true)
						elseif child:IsA("TextLabel") then
							TweenUtil:Create(child, TweenInfo.new(window.FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								TextTransparency = window.TransparencyCache[i]
							}, true)
						end
					end
				end
			end;
			Library:Connect(UserInputService.InputBegan, function(input, gameProcessed)
				if gameProcessed then
					return
				end;
				if input.KeyCode == Library.MenuKey then
					window:SetOpen()
				end
			end)
			window:SetTitle(window.Name)
			window.Elements = elements;
			return setmetatable(window, Library)
		end;
		function Library:Page(options)
			options = options or {}
			local page = {
				Window = self,
				Name = options.Name or options.name or "Page",
				SubPagesAllowed = options.SubPages or options.subpages or false,
				Columns = options.Columns or options.columns or 2,
				Active = false,
				ColumnsData = {},
				Elements = {}
			}
			local elements = {}
			elements["Inactive"] = InstanceUtil:Create("TextButton", {
				Parent = page.Window.Elements["Pages"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(0, 0, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				Name = "\0",
				BackgroundTransparency = 1,
				Size = NewUDim2(0, 0, 0, 20),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 14,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Inactive"].Object,
				PaddingRight = NewUDim(0, 5),
				PaddingLeft = NewUDim(0, 5)
			})
			elements["Liner"] = InstanceUtil:Create("Frame", {
				Parent = elements["Inactive"].Object,
				AnchorPoint = NewVector2(0, 1),
				Name = "\0",
				Position = NewUDim2(0, -5, 1, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 10, 0, 1),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3FromRGB(34, 34, 34)
			})
			elements["Liner"]:AddToTheme({
				BackgroundColor3 = "Accent"
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Inactive"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				TextTransparency = 0.28,
				Text = page.Name,
				Name = "\0",
				Size = NewUDim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BorderColor3 = Color3FromRGB(0, 0, 0),
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			elements["Glow"] = InstanceUtil:Create("Frame", {
				Parent = elements["Inactive"].Object,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(0, -5, 0, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 10, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(131, 194, 242)
			})
			elements["Glow"]:AddToTheme({
				BackgroundColor3 = "Accent"
			})
			InstanceUtil:Create("UIGradient", {
				Parent = elements["Glow"].Object,
				Rotation = -90,
				Transparency = NumberSequence.new{
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(0.078, 0.525),
					NumberSequenceKeypoint.new(0.198, 0.75),
					NumberSequenceKeypoint.new(0.402, 0.9),
					NumberSequenceKeypoint.new(1, 1)
				}
			})
			elements["PageContent"] = InstanceUtil:Create("Frame", {
				Parent = page.Window.Elements["Inline"].Object,
				Visible = false,
				BackgroundTransparency = 1,
				Name = "\0",
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["SubPages"] = InstanceUtil:Create("Frame", {
				Parent = elements["PageContent"].Object,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(0, 5, 0, 5),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -10, 0, 23),
				BorderSizePixel = 0,
				Visible = false,
				BackgroundColor3 = Color3FromRGB(17, 19, 22)
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["SubPages"].Object,
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalFlex = Enum.UIFlexAlignment.Fill,
				Padding = NewUDim(0, 5),
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			elements["Columns"] = InstanceUtil:Create("Frame", {
				Parent = elements["PageContent"].Object,
				Name = "\0",
				Position = NewUDim2(0, 6, 0, 35),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -12, 1, -41),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(12, 14, 16)
			})
			elements["Columns"]:AddToTheme({
				BackgroundColor3 = "Background"
			})
			if not page.SubPagesAllowed then
				InstanceUtil:Create("UIListLayout", {
					Parent = elements["Columns"].Object,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = NewUDim(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalFlex = Enum.UIFlexAlignment.Fill
				})
				InstanceUtil:Create("UIPadding", {
					Parent = elements["Columns"].Object,
					PaddingBottom = NewUDim(0, 8),
					PaddingLeft = NewUDim(0, 5),
					PaddingTop = NewUDim(0, 5),
					PaddingRight = NewUDim(0, 5)
				})
			end;
			elements["Columns"]:Border()
			if page.SubPagesAllowed then
				elements["SubPages"].Object.Visible = true;
				elements["Columns"].Object.Size = NewUDim2(1, -12, 1, -41)
				elements["Columns"].Object.Position = NewUDim2(0, 6, 0, 35)
			else
				elements["SubPages"].Object.Visible = false;
				elements["Columns"].Object.Size = NewUDim2(1, -12, 1, -12)
				elements["Columns"].Object.Position = NewUDim2(0, 6, 0, 6)
			end;
			if not page.SubPagesAllowed then
				for col = 1, page.Columns do
					local scrollFrame = InstanceUtil:Create("ScrollingFrame", {
						Parent = elements["Columns"].Object,
						ScrollBarImageColor3 = Color3FromRGB(131, 194, 242),
						MidImage = "rbxassetid://85239668542938",
						Active = true,
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						ScrollBarThickness = 1,
						Name = "\0",
						Size = NewUDim2(0, 100, 0, 100),
						BackgroundColor3 = Color3FromRGB(255, 255, 255),
						TopImage = "rbxassetid://85239668542938",
						BorderColor3 = Color3FromRGB(0, 0, 0),
						BackgroundTransparency = 1,
						BottomImage = "rbxassetid://85239668542938",
						BorderSizePixel = 0,
						CanvasSize = NewUDim2(0, 0, 0, 0)
					})
					scrollFrame:AddToTheme({
						ScrollBarImageColor3 = "Accent"
					})
					InstanceUtil:Create("UIPadding", {
						Parent = scrollFrame.Object,
						PaddingTop = NewUDim(0, 4),
						PaddingBottom = NewUDim(0, 4),
						PaddingRight = NewUDim(0, 1),
						PaddingLeft = NewUDim(0, 4)
					})
					InstanceUtil:Create("UIListLayout", {
						Parent = scrollFrame.Object,
						Padding = NewUDim(0, 12),
						SortOrder = Enum.SortOrder.LayoutOrder
					})
					page.ColumnsData[col] = scrollFrame
				end
			end;
			function page:Switch(active)
				page.Active = active;
				elements["PageContent"].Object.Visible = page.Active;
				if page.Active then
					elements["Text"]:Tween(nil, {
						TextTransparency = 0
					})
					elements["Liner"]:Tween(nil, {
						BackgroundTransparency = 0
					})
					elements["Glow"]:Tween(nil, {
						BackgroundTransparency = 0
					})
				else
					elements["Text"]:Tween(nil, {
						TextTransparency = 0.28
					})
					elements["Liner"]:Tween(nil, {
						BackgroundTransparency = 1
					})
					elements["Glow"]:Tween(nil, {
						BackgroundTransparency = 1
					})
				end
			end;
			elements["Inactive"]:Connect("MouseButton1Down", function()
				for _, p in page.Window.Pages do
					p:Switch(p == page)
				end
			end, page.Name .. " Switch Event")
			if #page.Window.Pages == 0 then
				page:Switch(true)
			end;
			page.Elements = elements;
			table.insert(page.Window.Pages, page)
			return setmetatable(page, Library.Pages)
		end;
		function Library.Pages:SubPage(options)
			options = options or {}
			local subPage = {
				Window = self.Window,
				Page = self,
				Name = options.Name or options.name or "SubPage",
				SubPagesAllowed = options.SubPages or options.subpages or false,
				Columns = options.Columns or options.columns or 2,
				Active = false,
				ColumnsData = {},
				Elements = {}
			}
			local elements = {}
			elements["Inactive"] = InstanceUtil:Create("TextButton", {
				Parent = subPage.Page.Elements["SubPages"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(0, 0, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				Name = "\0",
				BackgroundTransparency = 1,
				Size = NewUDim2(0, 0, 0, 20),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 14,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Inactive"].Object,
				PaddingRight = NewUDim(0, 5),
				PaddingLeft = NewUDim(0, 5)
			})
			elements["Liner"] = InstanceUtil:Create("Frame", {
				Parent = elements["Inactive"].Object,
				AnchorPoint = NewVector2(0, 1),
				Name = "\0",
				Position = NewUDim2(0, -5, 1, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 10, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(34, 34, 34)
			})
			elements["Liner"]:AddToTheme({
				BackgroundColor3 = "Accent"
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Inactive"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				TextTransparency = 0.28,
				Text = subPage.Name,
				Name = "\0",
				Size = NewUDim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BorderColor3 = Color3FromRGB(0, 0, 0),
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			elements["Glow"] = InstanceUtil:Create("Frame", {
				Parent = elements["Inactive"].Object,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(0, -5, 0, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 10, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(131, 194, 242)
			})
			elements["Glow"]:AddToTheme({
				BackgroundColor3 = "Accent"
			})
			InstanceUtil:Create("UIGradient", {
				Parent = elements["Glow"].Object,
				Rotation = -90,
				Transparency = NumberSequence.new{
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(0.078, 0.525),
					NumberSequenceKeypoint.new(0.198, 0.75),
					NumberSequenceKeypoint.new(0.402, 0.9),
					NumberSequenceKeypoint.new(1, 1)
				}
			})
			elements["SubPageContent"] = InstanceUtil:Create("Frame", {
				Parent = subPage.Page.Elements["Columns"].Object,
				Visible = false,
				BackgroundTransparency = 1,
				Name = "\0",
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["SubPageContent"].Object,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = NewUDim(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalFlex = Enum.UIFlexAlignment.Fill
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["SubPageContent"].Object,
				PaddingBottom = NewUDim(0, 8),
				PaddingLeft = NewUDim(0, 5),
				PaddingTop = NewUDim(0, 5),
				PaddingRight = NewUDim(0, 5)
			})
			for col = 1, subPage.Columns do
				local scrollFrame = InstanceUtil:Create("ScrollingFrame", {
					Parent = elements["SubPageContent"].Object,
					ScrollBarImageColor3 = Color3FromRGB(131, 194, 242),
					MidImage = "rbxassetid://85239668542938",
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollBarThickness = 1,
					Name = "\0",
					Size = NewUDim2(0, 100, 0, 100),
					BackgroundColor3 = Color3FromRGB(255, 255, 255),
					TopImage = "rbxassetid://85239668542938",
					BorderColor3 = Color3FromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BottomImage = "rbxassetid://85239668542938",
					BorderSizePixel = 0,
					CanvasSize = NewUDim2(0, 0, 0, 0)
				})
				scrollFrame:AddToTheme({
					ScrollBarImageColor3 = "Accent"
				})
				InstanceUtil:Create("UIPadding", {
					Parent = scrollFrame.Object,
					PaddingTop = NewUDim(0, 4),
					PaddingBottom = NewUDim(0, 4),
					PaddingRight = NewUDim(0, 1),
					PaddingLeft = NewUDim(0, 4)
				})
				InstanceUtil:Create("UIListLayout", {
					Parent = scrollFrame.Object,
					Padding = NewUDim(0, 12),
					SortOrder = Enum.SortOrder.LayoutOrder
				})
				subPage.ColumnsData[col] = scrollFrame
			end;
			function subPage:Switch(active)
				subPage.Active = active;
				elements["SubPageContent"].Object.Visible = subPage.Active;
				if subPage.Active then
					elements["Text"]:Tween(nil, {
						TextTransparency = 0
					})
					elements["Liner"]:Tween(nil, {
						BackgroundTransparency = 0
					})
					elements["Glow"]:Tween(nil, {
						BackgroundTransparency = 0
					})
				else
					elements["Text"]:Tween(nil, {
						TextTransparency = 0.28
					})
					elements["Liner"]:Tween(nil, {
						BackgroundTransparency = 1
					})
					elements["Glow"]:Tween(nil, {
						BackgroundTransparency = 1
					})
				end
			end;
			elements["Inactive"]:Connect("MouseButton1Down", function()
				for _, sp in subPage.Window.SubPages do
					sp:Switch(sp == subPage)
				end
			end, subPage.Name .. " Switch Event")
			table.insert(subPage.Window.SubPages, subPage)
			return setmetatable(subPage, Library.Pages)
		end;
		function Library.Pages:MultiSection(options)
			local multiSection = {
				Window = self.Window,
				Page = self,
				Name = options.Name or options.name or "MultiSection",
				Side = options.Side or options.side or 1,
				Sections = options.Sections or options.sections or {
					"One",
					"Two",
					"Three"
				},
				SectionContents = {},
				Elements = {}
			}
			local elements = {}
			elements["MultiSection"] = InstanceUtil:Create("Frame", {
				Parent = multiSection.Page.ColumnsData[multiSection.Side].Object,
				Name = "\0",
				Size = NewUDim2(1, -3, 0, 25),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3FromRGB(16, 16, 16)
			})
			elements["MultiSection"]:AddToTheme({
				BackgroundColor3 = "Inline"
			})
			elements["MultiSection"]:Border()
			InstanceUtil:Create("UIGradient", {
				Parent = elements["MultiSection"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.041, Color3FromRGB(189, 189, 189)),
					ColorSequenceKeypoint.new(0.315, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(255, 255, 255))
				}
			})
			elements["Sections"] = InstanceUtil:Create("Frame", {
				Parent = elements["MultiSection"].Object,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(0, 0, 0, 5),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -5, 0, 21),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["Sections"].Object,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = NewUDim(0, 5),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalFlex = Enum.UIFlexAlignment.Fill
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["MultiSection"].Object,
				PaddingBottom = NewUDim(0, 6),
				PaddingLeft = NewUDim(0, 6)
			})
			elements["Content"] = InstanceUtil:Create("Frame", {
				Parent = elements["MultiSection"].Object,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(0, 0, 0, 32),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -6, 1, -28),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			for _, sectionName in multiSection.Sections do
				local sectionObj = {
					Window = multiSection.Window,
					Page = multiSection.Page,
					Name = sectionName,
					Active = false,
					Elements = {}
				}
				local sectionElements = {}
				sectionElements["Inactive"] = InstanceUtil:Create("TextButton", {
					Parent = elements["Sections"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(0, 0, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Name = "\0",
					BackgroundTransparency = 1,
					Size = NewUDim2(0, 0, 0, 20),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 14,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				InstanceUtil:Create("UIPadding", {
					Parent = sectionElements["Inactive"].Object,
					PaddingRight = NewUDim(0, 5),
					PaddingLeft = NewUDim(0, 5)
				})
				sectionElements["Liner"] = InstanceUtil:Create("Frame", {
					Parent = sectionElements["Inactive"].Object,
					AnchorPoint = NewVector2(0, 1),
					Name = "\0",
					Position = NewUDim2(0, -5, 1, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Size = NewUDim2(1, 10, 0, 1),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3FromRGB(34, 34, 34)
				})
				sectionElements["Liner"]:AddToTheme({
					BackgroundColor3 = "Accent"
				})
				sectionElements["Text"] = InstanceUtil:Create("TextLabel", {
					Parent = sectionElements["Inactive"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(225, 227, 229),
					TextTransparency = 0.28,
					Text = sectionName,
					Name = "\0",
					Size = NewUDim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				sectionElements["Text"]:AddToTheme({
					TextColor3 = "Text"
				})
				sectionElements["Text"]:TextBorder()
				sectionElements["Glow"] = InstanceUtil:Create("Frame", {
					Parent = sectionElements["Inactive"].Object,
					Name = "\0",
					BackgroundTransparency = 1,
					Position = NewUDim2(0, -5, 0, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Size = NewUDim2(1, 10, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(131, 194, 242)
				})
				sectionElements["Glow"]:AddToTheme({
					BackgroundColor3 = "Accent"
				})
				InstanceUtil:Create("UIGradient", {
					Parent = sectionElements["Glow"].Object,
					Rotation = -90,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(0.078, 0.525),
						NumberSequenceKeypoint.new(0.198, 0.75),
						NumberSequenceKeypoint.new(0.402, 0.9),
						NumberSequenceKeypoint.new(1, 1)
					}
				})
				sectionElements["Content"] = InstanceUtil:Create("Frame", {
					Parent = elements["Content"].Object,
					BackgroundTransparency = 1,
					Name = "\0",
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Size = NewUDim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				InstanceUtil:Create("UIListLayout", {
					Parent = sectionElements["Content"].Object,
					Padding = NewUDim(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder
				})
				function sectionObj:Switch(active)
					sectionObj.Active = active;
					sectionElements["Content"].Object.Visible = sectionObj.Active;
					if sectionObj.Active then
						sectionElements["Text"]:Tween(nil, {
							TextTransparency = 0
						})
						sectionElements["Liner"]:Tween(nil, {
							BackgroundTransparency = 0
						})
						sectionElements["Glow"]:Tween(nil, {
							BackgroundTransparency = 0
						})
					else
						sectionElements["Text"]:Tween(nil, {
							TextTransparency = 0.28
						})
						sectionElements["Liner"]:Tween(nil, {
							BackgroundTransparency = 1
						})
						sectionElements["Glow"]:Tween(nil, {
							BackgroundTransparency = 1
						})
					end
				end;
				sectionElements["Inactive"]:Connect("MouseButton1Down", function()
					for _, s in multiSection.SectionContents do
						s:Switch(s == sectionObj)
					end
				end, sectionObj.Name .. " Switch Event")
				if #multiSection.SectionContents == 0 then
					sectionObj:Switch(true)
				end;
				sectionObj.Elements = sectionElements;
				multiSection.SectionContents[#multiSection.SectionContents + 1] = setmetatable(sectionObj, Library.Sections)
			end;
			multiSection.SectionContents[1]:Switch(true)
			multiSection.Window.Sections[#multiSection.Window.Sections + 1] = multiSection;
			return table.unpack(multiSection.SectionContents)
		end;
		function Library.Pages:Section(options)
			options = options or {}
			local section = {
				Window = self.Window,
				Page = self,
				Name = options.Name or options.name or "Section",
				Side = options.Side or options.side or 1,
				Elements = {}
			}
			local elements = {}
			elements["Section"] = InstanceUtil:Create("Frame", {
				Parent = section.Page.ColumnsData[section.Side].Object,
				Name = "\0",
				Size = NewUDim2(1, -3, 0, 25),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3FromRGB(16, 16, 16)
			})
			elements["Section"]:AddToTheme({
				BackgroundColor3 = "Inline"
			})
			elements["Section"]:Border()
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Section"].Object,
				PaddingBottom = NewUDim(0, 6),
				PaddingLeft = NewUDim(0, 6)
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Section"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(229, 229, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = section.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 15),
				Position = NewUDim2(0, -1, 0, 3),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			elements["Liner"] = InstanceUtil:Create("Frame", {
				Parent = elements["Section"].Object,
				Name = "\0",
				Position = NewUDim2(0, -1, 0, 20),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -4, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(34, 34, 34)
			})
			elements["Liner"]:AddToTheme({
				BackgroundColor3 = "Border"
			})
			elements["Content"] = InstanceUtil:Create("Frame", {
				Parent = elements["Section"].Object,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(0, 0, 0, 28),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -6, 1, -28),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["Content"].Object,
				Padding = NewUDim(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			section.Elements = elements;
			return setmetatable(section, Library.Sections)
		end;
		function Library.Pages:ScrollableSection(options)
			options = options or {}
			local section = {
				Window = self.Window,
				Page = self,
				Name = options.Name or options.name or "ScrollableSection",
				Side = options.Side or options.side or 1,
				SectionSize = options.SectionSize or options.sectionsize or 155,
				CanvasSize = options.CanvasSize or options.canvassize or 185,
				Elements = {}
			}
			local elements = {}
			elements["ScrollableSection"] = InstanceUtil:Create("Frame", {
				Parent = section.Page.ColumnsData[section.Side].Object,
				Name = "\0",
				Size = NewUDim2(1, -3, 0, 25),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3FromRGB(16, 16, 16)
			})
			elements["ScrollableSection"]:AddToTheme({
				BackgroundColor3 = "Inline"
			})
			elements["ScrollableSection"]:Border()
			InstanceUtil:Create("UIPadding", {
				Parent = elements["ScrollableSection"].Object,
				PaddingBottom = NewUDim(0, 6),
				PaddingLeft = NewUDim(0, 6)
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["ScrollableSection"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(229, 229, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = section.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 15),
				Position = NewUDim2(0, -1, 0, 3),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			elements["Liner"] = InstanceUtil:Create("Frame", {
				Parent = elements["ScrollableSection"].Object,
				Name = "\0",
				Position = NewUDim2(0, -1, 0, 20),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, -4, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(34, 34, 34)
			})
			elements["Liner"]:AddToTheme({
				BackgroundColor3 = "Border"
			})
			InstanceUtil:Create("UIGradient", {
				Parent = elements["ScrollableSection"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.041, Color3FromRGB(189, 189, 189)),
					ColorSequenceKeypoint.new(0.315, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(255, 255, 255))
				}
			})
			elements["Content"] = InstanceUtil:Create("ScrollingFrame", {
				Parent = elements["ScrollableSection"].Object,
				ScrollBarImageColor3 = Color3FromRGB(131, 194, 242),
				MidImage = "rbxassetid://85239668542938",
				Active = true,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 1,
				Name = "\0",
				Size = NewUDim2(1, -6, 0, 125),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BackgroundColor3 = Color3FromRGB(255, 255, 255),
				TopImage = "rbxassetid://85239668542938",
				Position = NewUDim2(0, 0, 0, 28),
				BackgroundTransparency = 1,
				BottomImage = "rbxassetid://85239668542938",
				BorderSizePixel = 0,
				CanvasSize = NewUDim2(0, 0, 0, 0)
			})
			elements["Content"]:AddToTheme({
				ScrollBarImageColor3 = "Accent"
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["Content"].Object,
				Padding = NewUDim(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Content"].Object,
				PaddingBottom = NewUDim(0, 6),
				PaddingLeft = NewUDim(0, 5),
				PaddingRight = NewUDim(0, 5),
				PaddingTop = NewUDim(0, 2)
			})
			section.Elements = elements;
			return setmetatable(section, Library.Sections)
		end;
		function Library.Sections:Toggle(options)
			options = options or {}
			local toggle = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = options.Name or options.name or "Toggle",
				Default = options.Default or options.default or false,
				Flag = options.Flag or options.flag or Library:NextFlag(),
				Callback = options.Callback or options.callback or function()
				end,
				Value = false,
				Class = "Toggle",
				Count = 0
			}
			local elements = {}
			elements["Toggle"] = InstanceUtil:Create("TextButton", {
				Parent = toggle.Section.Elements["Content"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(0, 0, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Name = "\0",
				Size = NewUDim2(1, 0, 0, 13),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Indicator"] = InstanceUtil:Create("Frame", {
				Parent = elements["Toggle"].Object,
				Name = "\0",
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(0, 12, 0, 12),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(15, 15, 15)
			})
			elements["Indicator"]:AddToTheme({
				BackgroundColor3 = "Element"
			})
			elements["Indicator"]:Border():AddHoverEffect(true)
			InstanceUtil:Create("UIGradient", {
				Parent = elements["Indicator"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(86, 86, 86))
				}
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Toggle"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				TextTransparency = 0.28,
				Text = toggle.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 15),
				Position = NewUDim2(0, 18, 0, -1),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderColor3 = Color3FromRGB(0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			function toggle:Set(value)
				toggle.Value = value or not toggle.Value;
				if toggle.Value then
					elements["Text"]:Tween(nil, {
						TextTransparency = 0,
						TextColor3 = Library.Theme.Accent
					})
					elements["Indicator"]:Tween(nil, {
						BackgroundColor3 = Library.Theme.Accent
					})
					elements["Indicator"]:ChangeObjectTheme({
						BackgroundColor3 = "Accent"
					})
					elements["Text"]:ChangeObjectTheme({
						TextColor3 = "Accent"
					})
				else
					elements["Text"]:Tween(nil, {
						TextTransparency = 0.28,
						TextColor3 = Library.Theme.Text
					})
					elements["Indicator"]:Tween(nil, {
						BackgroundColor3 = Library.Theme.Element
					})
					elements["Indicator"]:ChangeObjectTheme({
						BackgroundColor3 = "Element"
					})
					elements["Text"]:ChangeObjectTheme({
						TextColor3 = "Text"
					})
				end;
				if toggle.Callback then
					pcall(toggle.Callback, toggle.Value)
				end
			end;
			function toggle:Get()
				return toggle.Value
			end;
			function toggle:Colorpicker(cpOptions)
				local cpData = {
					Window = self.Window,
					Tab = self.Tab,
					Section = self.Section,
					Parent = elements["Toggle"],
					Name = cpOptions.Name or cpOptions.name or "Colorpicker",
					Flag = cpOptions.Flag or cpOptions.flag or Library:NextFlag(),
					Default = cpOptions.Default or cpOptions.default or Color3.fromRGB(255, 255, 255),
					Callback = cpOptions.Callback or cpOptions.callback or function()
					end,
					Count = toggle.Count
				}
				toggle.Count = toggle.Count + 1;
				cpData.Count = toggle.Count;
				local cp = Library:Colorpicker(cpData)
				Library.Flags[cpData.Flag] = cp;
				return cpData
			end;
			function toggle:Keybind(kbOptions)
				local kbData = {
					Window = self.Window,
					Tab = self.Tab,
					Section = self.Section,
					Parent = elements["Toggle"],
					Name = kbOptions.Name or kbOptions.name or "Keybind",
					Flag = kbOptions.Flag or kbOptions.flag or Library:NextFlag(),
					Default = kbOptions.Default or kbOptions.default or "None",
					Callback = kbOptions.Callback or kbOptions.callback or function()
					end
				}
				local kb = Library:Keybind(kbData)
				Library.Flags[kbData.Flag] = kb;
				return kbData
			end;
			function toggle:SetVisiblity(visible)
				elements["Toggle"].Object.Visible = visible or true
			end;
			elements["Toggle"]:Connect("MouseButton1Down", function()
				toggle:Set()
			end, toggle.Name .. " Toggle Event")
			if toggle.Default then
				toggle:Set(toggle.Default)
			end;
			Library.Flags[toggle.Flag] = toggle;
			return toggle
		end;
		function Library.Sections:Button(options)
			options = options or {}
			local button = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = options.Name or options.name or "Button",
				Callback = options.Callback or options.callback or function()
				end
			}
			local elements = {}
			elements["Button"] = InstanceUtil:Create("TextButton", {
				Parent = button.Section.Elements["Content"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(0, 0, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				Name = "\0",
				Size = NewUDim2(1, 0, 0, 18),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = Color3FromRGB(15, 15, 15)
			})
			elements["Button"]:AddToTheme({
				BackgroundColor3 = "Element"
			})
			elements["Button"]:Border():AddHoverEffect(false)
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Button"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = button.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 1, 0),
				AnchorPoint = NewVector2(0.5, 0.5),
				Position = NewUDim2(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			InstanceUtil:Create("UIGradient", {
				Parent = elements["Button"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(86, 86, 86))
				}
			})
			function button:Press()
				elements["Button"]:Tween(nil, {
					BackgroundColor3 = Library.Theme.Accent
				})
				elements["Button"]:ChangeObjectTheme({
					BackgroundColor3 = "Accent"
				})
				task.wait(0.095)
				elements["Button"]:Tween(nil, {
					BackgroundColor3 = Library.Theme.Element
				})
				elements["Button"]:ChangeObjectTheme({
					BackgroundColor3 = "Element"
				})
				pcall(button.Callback)
			end;
			function button:Sub(subOptions)
				subOptions = subOptions or {}
				local subButton = {
					Window = self.Window,
					Page = self.Page,
					Section = self,
					Name = subOptions.Name or subOptions.name,
					Callback = subOptions.Callback or subOptions.callback or function()
					end
				}
				local subElements = {}
				elements["ButtonHolder"] = InstanceUtil:Create("Frame", {
					Parent = button.Section.Elements["Content"].Object,
					Name = "\0",
					Size = NewUDim2(1, 0, 0, 18),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3FromRGB(255, 255, 255),
					BackgroundTransparency = 1
				})
				elements["Button"].Object.Parent = elements["ButtonHolder"].Object;
				elements["Button"].Object.Size = NewUDim2(0.5, -3, 0, 18)
				subElements["Sub"] = InstanceUtil:Create("TextButton", {
					Parent = elements["ButtonHolder"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(0, 0, 0),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					AnchorPoint = NewVector2(1, 0),
					Name = "\0",
					Position = NewUDim2(1, 0, 0, 0),
					Size = NewUDim2(0.5, -3, 0, 18),
					BorderSizePixel = 0,
					TextSize = 14,
					BackgroundColor3 = Color3FromRGB(15, 15, 15)
				})
				subElements["Sub"]:AddToTheme({
					BackgroundColor3 = "Element"
				})
				subElements["Sub"]:Border():AddHoverEffect(false)
				subElements["Text"] = InstanceUtil:Create("TextLabel", {
					Parent = subElements["Sub"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(225, 227, 229),
					BorderColor3 = Color3FromRGB(0, 0, 0),
					Text = subButton.Name,
					Name = "\0",
					Size = NewUDim2(0, 0, 1, 0),
					AnchorPoint = NewVector2(0.5, 0.5),
					Position = NewUDim2(0.5, 0, 0.5, 1),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				subElements["Text"]:AddToTheme({
					TextColor3 = "Text"
				})
				subElements["Text"]:TextBorder()
				InstanceUtil:Create("UIGradient", {
					Parent = subElements["Sub"].Object,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3FromRGB(86, 86, 86))
					}
				})
				function subButton:Press()
					subElements["Sub"]:Tween(nil, {
						BackgroundColor3 = Library.Theme.Accent
					})
					subElements["Sub"]:ChangeObjectTheme({
						BackgroundColor3 = "Accent"
					})
					task.wait(0.095)
					subElements["Sub"]:Tween(nil, {
						BackgroundColor3 = Library.Theme.Element
					})
					subElements["Sub"]:ChangeObjectTheme({
						BackgroundColor3 = "Element"
					})
					pcall(subButton.Callback)
				end;
				function subButton:SetVisiblity(visible)
					subElements["Sub"].Object.Visible = visible or true
				end;
				subElements["Sub"]:Connect("MouseButton1Down", function()
					subButton:Press()
				end, subButton.Name .. " Press Event")
			end;
			function button:SetVisiblity(visible)
				elements["Button"].Object.Visible = visible or true
			end;
			elements["Button"]:Connect("MouseButton1Down", function()
				button:Press()
			end, button.Name .. " Press Event")
			return button
		end;
		function Library.Sections:Slider(options)
			options = options or {}
			local slider = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = options.Name or options.name or "Slider",
				Min = options.Min or options.min or 0,
				Default = options.Default or options.default or 0,
				Max = options.Max or options.max or 100,
				Flag = options.Flag or options.flag or Library:NextFlag(),
				Suffix = options.Suffix or options.suffix or "",
				Decimals = options.Decimals or options.decimals or 1,
				Callback = options.Callback or options.callback or function()
				end,
				Value = 0,
				Class = "Slider"
			}
			local elements = {}
			elements["Slider"] = InstanceUtil:Create("Frame", {
				Parent = slider.Section.Elements["Content"].Object,
				BackgroundTransparency = 1,
				Name = "\0",
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, 27),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Slider"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = slider.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 13),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			elements["Indicator"] = InstanceUtil:Create("TextButton", {
				Parent = elements["Slider"].Object,
				AnchorPoint = NewVector2(0, 1),
				AutoButtonColor = false,
				Text = "",
				Name = "\0",
				Position = NewUDim2(0, 0, 1, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, 8),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(15, 15, 15)
			})
			elements["Indicator"]:AddToTheme({
				BackgroundColor3 = "Element"
			})
			elements["Indicator"]:Border():AddHoverEffect(true)
			InstanceUtil:Create("UIGradient", {
				Parent = elements["Indicator"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(86, 86, 86))
				}
			})
			elements["Accent"] = InstanceUtil:Create("Frame", {
				Parent = elements["Indicator"].Object,
				Name = "\0",
				Position = NewUDim2(0, 0, 0, -1),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(0.25, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(131, 194, 242)
			})
			elements["Accent"]:AddToTheme({
				BackgroundColor3 = "Accent"
			})
			InstanceUtil:Create("UIGradient", {
				Parent = elements["Accent"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(159, 159, 159))
				}
			})
			elements["Value"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Indicator"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "25%",
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 13),
				AnchorPoint = NewVector2(0.5, 0),
				Position = NewUDim2(0.5, 0, 0, -2),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Value"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Value"]:TextBorder()
			elements["Minus"] = InstanceUtil:Create("TextButton", {
				Parent = elements["Slider"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "-",
				AutoButtonColor = false,
				AnchorPoint = NewVector2(1, 0),
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(1, -12, 0, 0),
				Size = NewUDim2(0, 15, 0, 15),
				BorderSizePixel = 0,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Minus"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Minus"]:TextBorder()
			elements["Plus"] = InstanceUtil:Create("TextButton", {
				Parent = elements["Slider"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "+",
				AutoButtonColor = false,
				AnchorPoint = NewVector2(1, 0),
				Name = "\0",
				BackgroundTransparency = 1,
				Position = NewUDim2(1, 0, 0, 0),
				Size = NewUDim2(0, 15, 0, 15),
				BorderSizePixel = 0,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Plus"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Plus"]:TextBorder()
			local isDragging = false;
			function slider:Set(value)
				slider.Value = Library:Floor(math.clamp(value, slider.Min, slider.Max), slider.Decimals)
				elements["Accent"]:Tween(TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Size = NewUDim2((slider.Value - slider.Min) / (slider.Max - slider.Min), 0, 1, 0)
				})
				elements["Value"].Object.Text = tostring(slider.Value) .. slider.Suffix;
				if slider.Callback then
					pcall(slider.Callback, slider.Value)
				end
			end;
			function slider:Get()
				return slider.Value
			end;
			function slider:SetVisiblity(visible)
				elements["Slider"].Object.Visible = visible or true
			end;
			elements["Indicator"]:Connect("MouseButton1Down", function()
				isDragging = true;
				local relX = (Mouse.X - elements["Indicator"].Object.AbsolutePosition.X) / elements["Indicator"].Object.AbsoluteSize.X;
				local mapped = ((slider.Max - slider.Min) * relX) + slider.Min;
				slider:Set(mapped)
			end, slider.Name .. " - InputBegan(Indicator)")
			elements["Indicator"]:Connect("InputEnded", function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDragging = false
				end
			end, slider.Name .. " - InputEnded(Indicator)")
			Library:Connect(UserInputService.InputChanged, function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
					local relX = (input.Position.X - elements["Indicator"].Object.AbsolutePosition.X) / elements["Indicator"].Object.AbsoluteSize.X;
					local mapped = ((slider.Max - slider.Min) * relX) + slider.Min;
					slider:Set(mapped)
				end
			end, slider.Name .. " - InputChanged")
			elements["Plus"]:Connect("MouseButton1Click", function()
				slider:Set(slider.Value + slider.Decimals)
			end, slider.Name .. " - Clicked(Plus)")
			elements["Minus"]:Connect("MouseButton1Click", function()
				slider:Set(slider.Value - slider.Decimals)
			end, slider.Name .. " - Clicked(Minus)")
			if slider.Default then
				slider:Set(slider.Default)
			end;
			Library.Flags[slider.Flag] = slider;
			return slider
		end;
		function Library.Sections:Dropdown(options)
			options = options or {}
			local dropdown = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = options.Name or options.name or "Dropdown",
				List = options.List or options.list or {},
				Multi = options.Multi or options.multi or false,
				Default = options.Default or options.default or 1,
				Flag = options.Flag or options.flag or Library:NextFlag(),
				Callback = options.Callback or options.callback or function()
				end,
				Value = "",
				IsOpen = false,
				Options = {},
				Class = "Dropdown"
			}
			local elements = {}
			elements["Dropdown"] = InstanceUtil:Create("Frame", {
				Parent = dropdown.Section.Elements["Content"].Object,
				BackgroundTransparency = 1,
				Name = "\0",
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, 34),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Dropdown"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = dropdown.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 13),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			elements["RealDropdown"] = InstanceUtil:Create("Frame", {
				Parent = elements["Dropdown"].Object,
				AnchorPoint = NewVector2(0, 1),
				Name = "\0",
				Position = NewUDim2(0, 0, 1, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, 17),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(15, 15, 15)
			})
			elements["RealDropdown"]:AddToTheme({
				BackgroundColor3 = "Element"
			})
			elements["RealDropdown"]:Border():AddHoverEffect(true)
			InstanceUtil:Create("UIGradient", {
				Parent = elements["RealDropdown"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(86, 86, 86))
				}
			})
			elements["Value"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["RealDropdown"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "Option",
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 13),
				Position = NewUDim2(0, 5, 0, 2),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Value"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Value"]:TextBorder()
			elements["Open"] = InstanceUtil:Create("TextButton", {
				Parent = elements["RealDropdown"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(0, 0, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Name = "\0",
				Size = NewUDim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["OpenIcon"] = InstanceUtil:Create("ImageLabel", {
				Parent = elements["RealDropdown"].Object,
				ScaleType = Enum.ScaleType.Fit,
				ImageTransparency = 0.28,
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Name = "\0",
				AnchorPoint = NewVector2(1, 0),
				Image = "rbxassetid://74303691547053",
				BackgroundTransparency = 1,
				Position = NewUDim2(1, -5, 0, 2),
				Size = NewUDim2(0, 12, 0, 12),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Liner"] = InstanceUtil:Create("Frame", {
				Parent = elements["RealDropdown"].Object,
				AnchorPoint = NewVector2(1, 0),
				Name = "\0",
				Position = NewUDim2(1, -22, 0, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(0, 1, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(34, 34, 34)
			})
			elements["Liner"]:AddToTheme({
				BackgroundColor3 = "Border"
			})
			elements["OptionHolder"] = InstanceUtil:Create("Frame", {
				Parent = elements["Dropdown"].Object,
				Visible = false,
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Name = "\0",
				Position = NewUDim2(0, 0, 1, 4),
				Size = NewUDim2(1, 0, 0, 15),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3FromRGB(16, 16, 16)
			})
			elements["OptionHolder"]:AddToTheme({
				BackgroundColor3 = "Inline"
			})
			elements["OptionHolder"]:Border()
			InstanceUtil:Create("UIGradient", {
				Parent = elements["OptionHolder"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.041, Color3FromRGB(189, 189, 189)),
					ColorSequenceKeypoint.new(0.315, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(255, 255, 255))
				}
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["OptionHolder"].Object,
				PaddingTop = NewUDim(0, 2),
				PaddingBottom = NewUDim(0, 2),
				PaddingRight = NewUDim(0, 6),
				PaddingLeft = NewUDim(0, 6)
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["OptionHolder"].Object,
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			function dropdown:Set(value)
				if dropdown.Multi then
					if type(value) ~= "table" then
						return
					end;
					dropdown.Value = value;
					for _, opt in dropdown.Options do
						if not table.find(value, opt.Name) then
							opt.IsSelected = false;
							opt.Button:Tween(nil, {
								TextColor3 = Library.Theme.Text,
								TextTransparency = 0.28
							})
							opt.Button:ChangeObjectTheme({
								TextColor3 = "Text"
							})
						end
					end;
					for _, name in value do
						dropdown.Options[name].IsSelected = true;
						dropdown.Options[name].Button:Tween(nil, {
							TextColor3 = Library.Theme.Accent,
							TextTransparency = 0
						})
						dropdown.Options[name].Button:ChangeObjectTheme({
							TextColor3 = "Accent"
						})
					end;
					elements["Value"].Object.Text = #value > 0 and table.concat(value, ", ") or "--"
				else
					local opt = dropdown.Options[value]
					if not opt then
						return
					end;
					dropdown.Value = value;
					for _, o in dropdown.Options do
						if o ~= opt then
							o.IsSelected = false;
							o.Button:Tween(nil, {
								TextColor3 = Library.Theme.Text,
								TextTransparency = 0.28
							})
							o.Button:ChangeObjectTheme({
								TextColor3 = "Text"
							})
						end
					end;
					opt.Button:Tween(nil, {
						TextColor3 = Library.Theme.Accent,
						TextTransparency = 0
					})
					opt.Button:ChangeObjectTheme({
						TextColor3 = "Accent"
					})
					opt.IsSelected = true;
					elements["Value"].Object.Text = opt.IsSelected and opt.Name or "--"
				end;
				if dropdown.Callback then
					pcall(dropdown.Callback, dropdown.Value)
				end
			end;
			local transparencyCache = {}
			local function cacheTransparency(key, value)
				if not transparencyCache[key] then
					transparencyCache[key] = value
				end
			end;
			function dropdown:SetOpen(forceState)
				dropdown.IsOpen = forceState or not dropdown.IsOpen;
				elements["OptionHolder"].Object.ZIndex = dropdown.IsOpen and 15 or 1;
				if dropdown.IsOpen then
					elements["OptionHolder"].Object.Visible = true;
					elements["OptionHolder"]:Tween(nil, {
						BackgroundTransparency = 0
					})
					task.wait(0.1)
					for i, child in elements["OptionHolder"].Object:GetDescendants() do
						if child:IsA("UIStroke") then
							TweenUtil:Create(child, nil, {
								Transparency = 0
							}, true)
						elseif child:IsA("TextButton") then
							local cached = transparencyCache[i]
							local trans = child.TextColor3 == Library.Theme.Accent and 0 or 0.28;
							TweenUtil:Create(child, nil, {
								TextTransparency = trans
							}, true)
							child.ZIndex = 15
						end
					end
				else
					for i, child in elements["OptionHolder"].Object:GetDescendants() do
						if child:IsA("UIStroke") then
							cacheTransparency(i, child.Transparency)
							TweenUtil:Create(child, nil, {
								Transparency = 1
							}, true)
						elseif child:IsA("TextButton") then
							cacheTransparency(i, child.TextTransparency)
							TweenUtil:Create(child, nil, {
								TextTransparency = 1
							}, true)
							child.ZIndex = 1
						end
					end;
					task.wait(0.1)
					elements["OptionHolder"]:Tween(nil, {
						BackgroundTransparency = 1
					})
					elements["OptionHolder"].Object.Visible = false
				end
			end;
			function dropdown:AddOption(name)
				local btn = InstanceUtil:Create("TextButton", {
					Parent = elements["OptionHolder"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(229, 229, 229),
					TextTransparency = 0.28,
					Text = name,
					AutoButtonColor = false,
					Name = "\0",
					Size = NewUDim2(1, 0, 0, 18),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				btn:AddToTheme({
					TextColor3 = "Text"
				})
				btn:TextBorder()
				local option = {
					Name = name,
					Button = btn,
					IsSelected = false
				}
				function option:Set()
					option.IsSelected = not option.IsSelected;
					if dropdown.Multi then
						local idx = table.find(dropdown.Value, name)
						if idx then
							table.remove(dropdown.Value, idx)
						else
							table.insert(dropdown.Value, name)
						end;
						elements["Value"].Object.Text = #dropdown.Value > 0 and table.concat(dropdown.Value, ", ") or "--"
						if idx then
							btn:Tween(nil, {
								TextColor3 = Library.Theme.Text,
								TextTransparency = 0.28
							})
							btn:ChangeObjectTheme({
								TextColor3 = "Text"
							})
						else
							btn:Tween(nil, {
								TextColor3 = Library.Theme.Accent,
								TextTransparency = 0
							})
							btn:ChangeObjectTheme({
								TextColor3 = "Accent"
							})
						end
					else
						if option.IsSelected then
							dropdown.Value = option.Name;
							for _, o in dropdown.Options do
								if o ~= option then
									o.IsSelected = false;
									o.Button:Tween(nil, {
										TextColor3 = Library.Theme.Text,
										TextTransparency = 0.28
									})
									o.Button:ChangeObjectTheme({
										TextColor3 = "Text"
									})
								end
							end;
							btn:Tween(nil, {
								TextColor3 = Library.Theme.Accent,
								TextTransparency = 0
							})
							btn:ChangeObjectTheme({
								TextColor3 = "Accent"
							})
							elements["Value"].Object.Text = option.Name
						else
							btn:Tween(nil, {
								TextColor3 = Library.Theme.Text,
								TextTransparency = 0.28
							})
							btn:ChangeObjectTheme({
								TextColor3 = "Text"
							})
							option.IsSelected = false;
							dropdown.Value = nil;
							elements["Value"].Object.Text = "--"
						end
					end;
					if dropdown.Callback then
						pcall(dropdown.Callback, dropdown.Value)
					end
				end;
				btn:Connect("MouseButton1Down", function()
					option:Set()
				end, dropdown.Name .. " Option " .. name .. " Event")
				dropdown.Options[name] = option
			end;
			function dropdown:RemoveOption(name)
				if dropdown.Options[name] then
					dropdown.Options[name].Button:Clean()
				end
			end;
			function dropdown:Refresh(list)
				for _, opt in dropdown.Options do
					dropdown:RemoveOption(opt.Name)
				end;
				for _, name in list do
					dropdown:AddOption(name)
				end
			end;
			function dropdown:Get()
				return dropdown.Value
			end;
			function dropdown:SetVisiblity(visible)
				elements["Dropdown"].Object.Visible = visible
			end;
			elements["Open"]:Connect("MouseButton1Down", function()
				dropdown:SetOpen()
			end, dropdown.Name .. " Open Event")
			for _, name in dropdown.List do
				dropdown:AddOption(name)
			end;
			if dropdown.Default then
				dropdown:Set(dropdown.Default)
			end;
			Library.Flags[dropdown.Flag] = dropdown;
			return dropdown
		end;
		function Library.Sections:Label(text)
			local label = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Count = 0
			}
			local elements = {}
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = label.Section.Elements["Content"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = text,
				Name = "\0",
				Size = NewUDim2(1, 0, 0, 15),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			function label:Colorpicker(cpOptions)
				local cpData = {
					Window = self.Window,
					Tab = self.Tab,
					Section = self.Section,
					Parent = elements["Text"],
					Name = cpOptions.Name or cpOptions.name or "Colorpicker",
					Flag = cpOptions.Flag or cpOptions.flag or Library:NextFlag(),
					Default = cpOptions.Default or cpOptions.default or Color3.fromRGB(255, 255, 255),
					Callback = cpOptions.Callback or cpOptions.callback or function()
					end,
					Count = label.Count
				}
				label.Count = label.Count + 1;
				cpData.Count = label.Count;
				local cp = Library:Colorpicker(cpData)
				Library.Flags[cpData.Flag] = cp;
				return cpData
			end;
			function label:Keybind(kbOptions)
				local kbData = {
					Window = self.Window,
					Tab = self.Tab,
					Section = self.Section,
					Parent = elements["Text"],
					Name = kbOptions.Name or kbOptions.name or "Keybind",
					Flag = kbOptions.Flag or kbOptions.flag or Library:NextFlag(),
					Default = kbOptions.Default or kbOptions.default or "None",
					Callback = kbOptions.Callback or kbOptions.callback or function()
					end
				}
				local kb = Library:Keybind(kbData)
				Library.Flags[kbData.Flag] = kb;
				return kbData
			end;
			return label
		end;
		function Library.Sections:Textbox(options)
			options = options or {}
			local textbox = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = options.Name or options.name or "Textbox",
				Flag = options.Flag or options.flag or Library:NextFlag(),
				Placeholder = options.Placeholder or options.placeholder or ". . .",
				Default = options.Default or options.default or "",
				Callback = options.Callback or options.callback or function()
				end,
				Value = "",
				Class = "Textbox"
			}
			local elements = {}
			elements["Textbox"] = InstanceUtil:Create("Frame", {
				Parent = textbox.Section.Elements["Content"].Object,
				BackgroundTransparency = 1,
				Name = "\0",
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, 34),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Textbox"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = textbox.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 13),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			elements["Background"] = InstanceUtil:Create("Frame", {
				Parent = elements["Textbox"].Object,
				AnchorPoint = NewVector2(0, 1),
				Name = "\0",
				Position = NewUDim2(0, 0, 1, 0),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, 17),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(15, 15, 15)
			})
			elements["Background"]:AddToTheme({
				BackgroundColor3 = "Element"
			})
			elements["Background"]:Border():AddHoverEffect(true)
			InstanceUtil:Create("UIGradient", {
				Parent = elements["Background"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(86, 86, 86))
				}
			})
			elements["Inline"] = InstanceUtil:Create("TextBox", {
				Parent = elements["Background"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(229, 229, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = "",
				Name = "\0",
				Size = NewUDim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				PlaceholderColor3 = Color3FromRGB(178, 178, 178),
				TextXAlignment = Enum.TextXAlignment.Left,
				PlaceholderText = textbox.Placeholder,
				TextSize = 12,
				ClearTextOnFocus = false,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Inline"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Inline"]:TextBorder()
			InstanceUtil:Create("UIPadding", {
				Parent = elements["Background"].Object,
				PaddingRight = NewUDim(0, 5),
				PaddingLeft = NewUDim(0, 5)
			})
			function textbox:Set(value)
				elements["Inline"].Object.Text = value;
				textbox.Value = value;
				if textbox.Callback then
					pcall(textbox.Callback, textbox.Value)
				end
			end;
			function textbox:Get()
				return textbox.Value
			end;
			function textbox:SetVisiblity(visible)
				elements["Textbox"].Object.Visible = visible
			end;
			elements["Inline"]:Connect("Focused", function()
				elements["Inline"]:Tween(nil, {
					TextColor3 = Library.Theme.Accent
				})
				elements["Inline"]:ChangeObjectTheme({
					TextColor3 = "Accent"
				})
			end, textbox.Name .. " Focused")
			elements["Inline"]:Connect("FocusLost", function()
				elements["Inline"]:Tween(nil, {
					TextColor3 = Library.Theme.Text
				})
				elements["Inline"]:ChangeObjectTheme({
					TextColor3 = "Text"
				})
				textbox:Set(elements["Inline"].Object.Text)
			end, textbox.Name .. " Unfocused")
			if textbox.Default then
				textbox:Set(textbox.Default)
			end;
			Library.Flags[textbox.Flag] = textbox;
			return textbox
		end;
		function Library.Sections:Listbox(options)
			options = options or {}
			local listbox = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = options.Name or options.name or "Listbox",
				List = options.List or options.list or {},
				Multi = options.Multi or options.multi or false,
				Default = options.Default or options.default or 1,
				Flag = options.Flag or options.flag or Library:NextFlag(),
				Callback = options.Callback or options.callback or function()
				end,
				Size = options.Size or options.size or 175,
				Value = "",
				Options = {},
				Class = "Listbox"
			}
			local elements = {}
			elements["Listbox"] = InstanceUtil:Create("Frame", {
				Parent = listbox.Section.Elements["Content"].Object,
				BackgroundTransparency = 1,
				Name = "\0",
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Size = NewUDim2(1, 0, 0, listbox.Size),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"] = InstanceUtil:Create("TextLabel", {
				Parent = elements["Listbox"].Object,
				FontFace = Library.Font,
				TextColor3 = Color3FromRGB(225, 227, 229),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				Text = listbox.Name,
				Name = "\0",
				Size = NewUDim2(0, 0, 0, 15),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 12,
				BackgroundColor3 = Color3FromRGB(255, 255, 255)
			})
			elements["Text"]:AddToTheme({
				TextColor3 = "Text"
			})
			elements["Text"]:TextBorder()
			elements["RealListbox"] = InstanceUtil:Create("ScrollingFrame", {
				Parent = elements["Listbox"].Object,
				ScrollBarImageColor3 = Color3FromRGB(131, 194, 242),
				MidImage = "rbxassetid://85239668542938",
				Active = true,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 1,
				Name = "\0",
				Size = NewUDim2(1, 0, 1, -17),
				BackgroundColor3 = Color3FromRGB(12, 14, 16),
				TopImage = "rbxassetid://85239668542938",
				Position = NewUDim2(0, 0, 0, 17),
				BorderColor3 = Color3FromRGB(0, 0, 0),
				BottomImage = "rbxassetid://85239668542938",
				BorderSizePixel = 0,
				CanvasSize = NewUDim2(0, 0, 0, 0)
			})
			elements["RealListbox"]:AddToTheme({
				ScrollBarImageColor3 = "Accent",
				BackgroundColor3 = "Element"
			})
			elements["RealListbox"]:Border()
			InstanceUtil:Create("UIGradient", {
				Parent = elements["RealListbox"].Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.041, Color3FromRGB(189, 189, 189)),
					ColorSequenceKeypoint.new(0.315, Color3FromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3FromRGB(255, 255, 255))
				}
			})
			InstanceUtil:Create("UIListLayout", {
				Parent = elements["RealListbox"].Object,
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			InstanceUtil:Create("UIPadding", {
				Parent = elements["RealListbox"].Object,
				PaddingTop = NewUDim(0, 2),
				PaddingBottom = NewUDim(0, 2),
				PaddingRight = NewUDim(0, 6),
				PaddingLeft = NewUDim(0, 6)
			})
			function listbox:Set(value)
				if listbox.Multi then
					if type(value) ~= "table" then
						return
					end;
					listbox.Value = value;
					for _, opt in listbox.Options do
						if not table.find(value, opt.Name) then
							opt.IsSelected = false;
							opt.Button:Tween(nil, {
								TextColor3 = Library.Theme.Text,
								TextTransparency = 0.28
							})
							opt.Button:ChangeObjectTheme({
								TextColor3 = "Text"
							})
						end
					end;
					for _, name in value do
						listbox.Options[name].IsSelected = true;
						listbox.Options[name].Button:Tween(nil, {
							TextColor3 = Library.Theme.Accent,
							TextTransparency = 0
						})
						listbox.Options[name].Button:ChangeObjectTheme({
							TextColor3 = "Accent"
						})
					end
				else
					local opt = listbox.Options[value]
					if not opt then
						return
					end;
					listbox.Value = value;
					for _, o in listbox.Options do
						if o ~= opt then
							o.IsSelected = false;
							o.Button:Tween(nil, {
								TextColor3 = Library.Theme.Text,
								TextTransparency = 0.28
							})
							o.Button:ChangeObjectTheme({
								TextColor3 = "Text"
							})
						end
					end;
					opt.Button:Tween(nil, {
						TextColor3 = Library.Theme.Accent,
						TextTransparency = 0
					})
					opt.Button:ChangeObjectTheme({
						TextColor3 = "Accent"
					})
					opt.IsSelected = true
				end;
				if listbox.Callback then
					pcall(listbox.Callback, listbox.Value)
				end
			end;
			function listbox:AddOption(name)
				local btn = InstanceUtil:Create("TextButton", {
					Parent = elements["RealListbox"].Object,
					FontFace = Library.Font,
					TextColor3 = Color3FromRGB(229, 229, 229),
					TextTransparency = 0.28,
					Text = name,
					AutoButtonColor = false,
					Name = "\0",
					Size = NewUDim2(1, 0, 0, 18),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Center,
					BorderSizePixel = 0,
					BorderColor3 = Color3FromRGB(0, 0, 0),
					TextSize = 12,
					BackgroundColor3 = Color3FromRGB(255, 255, 255)
				})
				btn:AddToTheme({
					TextColor3 = "Text"
				})
				btn:TextBorder()
				local option = {
					Name = name,
					Button = btn,
					IsSelected = false
				}
				function option:Set()
					option.IsSelected = not option.IsSelected;
					if listbox.Multi then
						local idx = table.find(listbox.Value, name)
						if idx then
							table.remove(listbox.Value, idx)
						else
							table.insert(listbox.Value, name)
						end;
						if idx then
							btn:Tween(nil, {
								TextColor3 = Library.Theme.Text,
								TextTransparency = 0.28
							})
							btn:ChangeObjectTheme({
								TextColor3 = "Text"
							})
						else
							btn:Tween(nil, {
								TextColor3 = Library.Theme.Accent,
								TextTransparency = 0
							})
							btn:ChangeObjectTheme({
								TextColor3 = "Accent"
							})
						end
					else
						if option.IsSelected then
							listbox.Value = option.Name;
							for _, o in listbox.Options do
								if o ~= option then
									o.IsSelected = false;
									o.Button:Tween(nil, {
										TextColor3 = Library.Theme.Text,
										TextTransparency = 0.28
									})
									o.Button:ChangeObjectTheme({
										TextColor3 = "Text"
									})
								end
							end;
							btn:Tween(nil, {
								TextColor3 = Library.Theme.Accent,
								TextTransparency = 0
							})
							btn:ChangeObjectTheme({
								TextColor3 = "Accent"
							})
						else
							btn:Tween(nil, {
								TextColor3 = Library.Theme.Text,
								TextTransparency = 0.28
							})
							btn:ChangeObjectTheme({
								TextColor3 = "Text"
							})
							option.IsSelected = false;
							listbox.Value = nil
						end
					end;
					if listbox.Callback then
						pcall(listbox.Callback, listbox.Value)
					end
				end;
				btn:Connect("MouseButton1Down", function()
					option:Set()
				end, listbox.Name .. " Option " .. name .. " Event")
				listbox.Options[name] = option
			end;
			function listbox:RemoveOption(name)
				if listbox.Options[name] then
					listbox.Options[name].Button:Clean()
				end
			end;
			function listbox:Refresh(list)
				for _, opt in listbox.Options do
					listbox:RemoveOption(opt.Name)
				end;
				for _, name in list do
					listbox:AddOption(name)
				end
			end;
			function listbox:Get()
				return listbox.Value
			end;
			function listbox:SetVisiblity(visible)
				elements["Listbox"].Object.Visible = visible
			end;
			for _, name in listbox.List do
				listbox:AddOption(name)
			end;
			if listbox.Default then
				listbox:Set(listbox.Default)
			end;
			Library.Flags[listbox.Flag] = listbox;
			return listbox
		end
	end
end;
getgenv().Library = Library
return Library
