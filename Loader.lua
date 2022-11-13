local lfs = require "lfs"
local Path = require "path"
local m = {}

local API_DOC = "Blizzard_APIDocumentation"
local GEN_DOC = "Blizzard_APIDocumentationGenerated"

local function LoadFile(path)
	if lfs.attributes(path) then
		local file = loadfile(path)
		file()
	end
end

local function LoadAddon(path, name)
	local file = io.open(Path.join(path, name..".toc"))
	if not file then
		error(string.format("%s has no TOC file", name))
	end
	for line in file:lines() do
		if line:find("%.lua") then
			LoadFile(Path.join(path, line))
		end
	end
	file:close()
end

function m:main()
	require(Path.join(WowDocLoader_Path, "Compat"))
	LoadAddon(Path.join(WowDocLoader_Path, API_DOC), API_DOC)
	LoadAddon(Path.join(WowDocLoader_Path, GEN_DOC), GEN_DOC)
end

return m
