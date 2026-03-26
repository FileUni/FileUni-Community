module("luci.controller.fileuni", package.seeall)

function index()
	local fs = require "nixio.fs"
	if not fs.access("/etc/config/fileuni") then
		return
	end

	entry({"admin", "services", "fileuni"}, cbi("fileuni"), _("FileUni"), 60).dependent = true
end
