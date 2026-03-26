local fs = require "nixio.fs"
local sys = require "luci.sys"
local uci = require "luci.model.uci".cursor()

local default_config_dir = "/etc/fileuni"
local default_app_data_dir = "/var/lib/fileuni"
local default_work_dir = "/var/lib/fileuni"
local default_port = "19000"

local function trim(value)
	return (value or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function parse_server_bind(config_path)
	if not fs.access(config_path) then
		return nil, default_port, false
	end

	local handle = io.open(config_path, "r")
	if not handle then
		return nil, default_port, false
	end

	local current_section = ""
	local main_ip = nil
	local main_port = nil

	for raw_line in handle:lines() do
		local line = trim(raw_line:gsub("%s*#.*$", ""))
		local section = line:match("^%[([^%]]+)%]$")

		if section then
			current_section = trim(section)
		elseif current_section == "server" then
			local detected_ip = line:match('^main_ip%s*=%s*"(.-)"$')
				or line:match("^main_ip%s*=%s*'(.-)'$")
			if detected_ip and trim(detected_ip) ~= "" then
				main_ip = trim(detected_ip)
			end

			local detected_port = line:match("^main_port%s*=%s*(%d+)$")
			if detected_port and trim(detected_port) ~= "" then
				main_port = trim(detected_port)
			end
		end
	end

	handle:close()
	return main_ip, main_port or default_port, true
end

local function build_backend_meta()
	local config_dir = uci:get("fileuni", "main", "config_dir") or default_config_dir
	local config_path = config_dir .. "/config.toml"
	local host, port, has_config = parse_server_bind(config_path)
	local display_host = host or "router-host"
	local normalized_host = display_host:lower()
	local use_browser_host = normalized_host == "" or normalized_host == "0.0.0.0"
		or normalized_host == "::" or normalized_host == "127.0.0.1"
		or normalized_host == "localhost"

	local running = sys.call("/etc/init.d/fileuni running >/dev/null 2>&1") == 0
	local binary_exists = fs.access("/usr/bin/fileuni")

	return {
		config_dir = config_dir,
		config_path = config_path,
		host = host or "",
		port = port,
		has_config = has_config,
		use_browser_host = use_browser_host,
		running = running,
		binary_exists = binary_exists,
		status_text = running and "Running" or "Stopped",
		binary_text = binary_exists and "Installed" or "Missing",
		backend_hint = use_browser_host and ("http://<router-ip>:" .. port .. "/ui") or ("http://" .. display_host .. ":" .. port .. "/ui"),
		admin_reset_hint = "If the admin password is lost, delete " .. config_dir .. "/install.lock and restart FileUni to enter the setup wizard again.",
	}
end

local m = Map("fileuni", translate("FileUni"), translate("Configure the FileUni OpenWrt service and LuCI shortcut."))

local status = m:section(SimpleSection)
status.template = "fileuni/status"
status.fileuni_backend = build_backend_meta()

local s = m:section(TypedSection, "main", translate("Service"))
s.anonymous = true
s.addremove = false

local enabled = s:option(Flag, "enabled", translate("Enable on boot"))
enabled.rmempty = false
enabled.default = enabled.disabled

local config_dir = s:option(Value, "config_dir", translate("Config directory"))
config_dir.rmempty = false
config_dir.placeholder = default_config_dir
config_dir.description = translate("Directory containing config.toml and install.lock.")

local app_data_dir = s:option(Value, "app_data_dir", translate("App data directory"))
app_data_dir.rmempty = false
app_data_dir.placeholder = default_app_data_dir
app_data_dir.description = translate("Runtime data directory passed to --AppDataDir.")

local work_dir = s:option(Value, "work_dir", translate("Working directory"))
work_dir.rmempty = false
work_dir.placeholder = default_work_dir
work_dir.description = translate("Process working directory used by procd before FileUni starts.")

function m.on_after_commit(self)
	local service_script = "/etc/init.d/fileuni"
	if not fs.access(service_script) then
		return
	end

	local boot_enabled = uci:get_bool("fileuni", "main", "enabled")
	if boot_enabled then
		sys.call(service_script .. " enable >/dev/null 2>&1")
		sys.call(service_script .. " restart >/dev/null 2>&1")
	else
		sys.call(service_script .. " stop >/dev/null 2>&1")
		sys.call(service_script .. " disable >/dev/null 2>&1")
	end
end

return m
