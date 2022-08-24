local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

flutter_tools.setup({
  lsp = {
    color = {
      enabled = true,
      background = false
    }
  }
})
