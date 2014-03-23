function love.conf(t)
	io.stdout:setvbuf("no")
	t.console = true
	t.window.title = "Tundra Motherboard"

	t.window.height = 672
	t.window.width = 720
	t.window.borderless = false
end