-- Completely break GitLab Duo so it can't start
return {
  cmd = { 'false' },         -- Command that always fails
  autostart = false,
  filetypes = {},            -- No filetypes
  root_dir = function() end, -- No root detection
}
