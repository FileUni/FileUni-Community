module("luci.controller.fileuni", package.seeall)

local function trim(value)
	return (tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function compact_detail(detail)
	local normalized = trim(tostring(detail or ""):gsub("[%c]+", " "):gsub("%s+", " "))
	if #normalized > 220 then
		return normalized:sub(1, 217) .. "..."
	end

	return normalized
end

local function resolve_runtime_language(cursor)
	local i18n = require "fileuni.i18n"
	return i18n.resolve_runtime_language(i18n.read_configured_language(cursor))
end

local function failure_message(i18n, lang, result)
	local code = result and result.code or ""
	if code == "binary_missing" then
		return i18n.translate(lang, "binary_missing_notice")
	end

	if code == "unsupported_arch" then
		return i18n.format(lang, "unsupported_arch_notice", result.detail or "unknown")
	end

	if code == "release_fetch_failed" then
		return i18n.translate(lang, "release_fetch_failed")
	end

	if code == "release_unavailable" then
		return i18n.translate(lang, "release_unavailable")
	end

	if code == "release_no_matching_asset" then
		return i18n.translate(lang, "release_no_matching_asset")
	end

	if code == "service_script_missing" then
		return i18n.translate(lang, "service_script_missing")
	end

	if code == "invalid_channel" then
		return i18n.translate(lang, "invalid_channel")
	end

	if code == "invalid_action" then
		return i18n.translate(lang, "invalid_action")
	end

	local detail = compact_detail(result and result.detail)
	local base = i18n.translate(lang, "operation_failed")
	if detail ~= "" then
		return base .. ": " .. detail
	end

	return base
end

local function success_message(i18n, lang, result)
	local code = result and result.code or ""
	if code == "service_started" then
		return i18n.translate(lang, "service_started_success")
	end

	if code == "service_stopped" then
		return i18n.translate(lang, "service_stopped_success")
	end

	if code == "service_installed" then
		return i18n.translate(lang, "service_installed_success")
	end

	if code == "service_disabled" then
		return i18n.translate(lang, "service_disabled_success")
	end

	if code == "binary_installed" then
		return i18n.format(lang, "binary_installed_success", trim(result.version) ~= "" and result.version or "latest")
	end

	if code == "binary_removed" then
		return i18n.translate(lang, "binary_removed_success")
	end

	return i18n.translate(lang, "operation_completed")
end

local function redirect_with_notice(notice_type, message)
	local dispatcher = require "luci.dispatcher"
	local http = require "luci.http"
	local base = dispatcher.build_url("admin", "services", "fileuni")
	local query = string.format(
		"?fileuni_notice_type=%s&fileuni_notice=%s",
		http.urlencode(notice_type or "success"),
		http.urlencode(message or "")
	)
	http.redirect(base .. query)
end

function index()
	local fs = require "nixio.fs"
	if not fs.access("/etc/config/fileuni") then
		return
	end

	entry({"admin", "services", "fileuni"}, cbi("fileuni"), _("FileUni"), 60).dependent = true
	entry({"admin", "services", "fileuni", "set_lang"}, call("action_set_lang")).leaf = true
	entry({"admin", "services", "fileuni", "service_action"}, call("action_service_action")).leaf = true
	entry({"admin", "services", "fileuni", "binary_action"}, call("action_binary_action")).leaf = true
end

function action_set_lang()
	local dispatcher = require "luci.dispatcher"
	local http = require "luci.http"
	local i18n = require "fileuni.i18n"
	local cursor = require "luci.model.uci".cursor()
	local lang = http.formvalue("lang") or "auto"

	if not i18n.is_supported_config_language(lang) then
		http.status(400, i18n.translate("en", "unsupported_language"))
		http.prepare_content("text/plain")
		http.write(i18n.translate("en", "unsupported_language"))
		return
	end

	i18n.ensure_luci_languages(cursor)
	if not cursor:get("luci", "main") then
		cursor:section("luci", "core", "main", { lang = "auto" })
	end
	cursor:set("luci", "main", "lang", lang)
	cursor:commit("luci")

	local redirect = http.formvalue("redirect") or dispatcher.build_url("admin", "services", "fileuni")
	if redirect:sub(1, 1) ~= "/" then
		redirect = dispatcher.build_url("admin", "services", "fileuni")
	end

	http.redirect(redirect)
end

function action_service_action()
	local http = require "luci.http"
	local i18n = require "fileuni.i18n"
	local manager = require "fileuni.openwrt"
	local cursor = require "luci.model.uci".cursor()
	local lang = resolve_runtime_language(cursor)
	local result = manager.perform_service_action(cursor, http.formvalue("action"))
	local notice_type = result.ok and "success" or "error"
	local notice_message = result.ok
		and success_message(i18n, lang, result)
		or failure_message(i18n, lang, result)

	redirect_with_notice(notice_type, notice_message)
end

function action_binary_action()
	local http = require "luci.http"
	local i18n = require "fileuni.i18n"
	local manager = require "fileuni.openwrt"
	local cursor = require "luci.model.uci".cursor()
	local lang = resolve_runtime_language(cursor)
	local result = manager.perform_binary_action(http.formvalue("action"), http.formvalue("channel"))
	local notice_type = result.ok and "success" or "error"
	local notice_message = result.ok
		and success_message(i18n, lang, result)
		or failure_message(i18n, lang, result)

	redirect_with_notice(notice_type, notice_message)
end
