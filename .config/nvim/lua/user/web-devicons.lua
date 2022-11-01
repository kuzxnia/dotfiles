local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
  return
end

devicons.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  ['.gitignore']= {
    icon = "",
    color = "#d24939",
    cterm_color = "208",
    name = "DevIconGitIgnore"
  },
  ["Dockerfile"] = {
    icon = "",
    color = "#5fafff",
    cterm_color = "75",
    name = "Dockerfile",
  },
  ["dockerfile"] = {
    icon = "",
    color = "#5fafff",
    cterm_color = "75",
    name = "Dockerfile",
  },
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
