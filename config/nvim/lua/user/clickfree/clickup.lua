local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
  return
end

function get_tasks ()
  local tasks = neorg.modules.get_module("core.gtd.queries").get("tasks")
  local ret = neorg.modules.get_module("core.gtd.queries").add_metadata(tasks, "task")
  ret = vim.tbl_map(function (t) t.internal = nil return t end, ret)
  -- ret = vim.fn.json_encode(ret)
  print(vim.inspect(ret))
  return ret
end

