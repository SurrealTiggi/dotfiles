-- A herdr popup is an overlay, and herdr strips Kitty graphics placements under
-- overlays, so the stock image previewer draws nothing there. Use chafa instead.
local M = {}

local function in_popup()
	return os.getenv("HERDR_ACTIVE_PANE_ID") ~= nil and os.getenv("HERDR_PANE_ID") == nil
end

function M:peek(job)
	if not in_popup() then
		return require("image"):peek(job)
	end

	-- Prefer yazi's downscaled precache: chafa on a 6000px original takes ~1s.
	local url = ya.file_cache(job)
	if not url or not fs.cha(url) then
		url = job.file.url
	end

	local out, err = Command("chafa")
		:arg({
			"-f", "symbols", "--symbols", "block+quad+half+sextant+wedge", "-c", "full",
			"--polite", "on", "--animate", "off",
			"-s", string.format("%dx%d", job.area.w, job.area.h),
			tostring(url),
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not out or not out.status.success then
		local msg = err and tostring(err) or (out and out.stderr) or "chafa failed"
		return require("empty").msg(job, msg)
	end
	ya.preview_widget(job, ui.Text.parse(out.stdout):area(job.area))
end

function M:seek() end

function M:preload(job) return require("image"):preload(job) end

function M:spot(job) return require("image"):spot(job) end

return M
