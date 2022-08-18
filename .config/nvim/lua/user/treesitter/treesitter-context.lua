local status_ok, tcontext = pcall(require, "treesitter-context")
if not status_ok then
  return
end

tcontext.setup {}
