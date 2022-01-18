local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("json")

local M = {}

local meta = {
	headers = { ["Authorization"] = "pk_37666252_S1UCT0Y8ICL1PL369HDKOO851S86EG7J" },
	base_url = "https://api.clickup.com/api/v2",
}

local format_url = function(s)
	return meta.base_url .. "/" .. s
end

local function query_factory(method)
	local function query(s)
		setmetatable(s, { __index = { headers =  meta.headers  } })
    local url_modifier, headers =
      s[1] or s.url_modifier,
      s[2] or s.headers
    local url = format_url(url_modifier)
    local t = {}
		local status = https.request({
			url = url,
			headers = headers,
			method = method,
			sink = ltn12.sink.table(t),
		})
    local result = ""
    -- parse the jsons!
    for _, value in ipairs(t) do
      result = result .. value
    end
    result = json.decode(result)
    return result

	end
  return query
end

local api = {
  get = query_factory("GET"),
  post = query_factory("POST"),
  put = query_factory("PUT"),
  delete = query_factory("DELETE"),
}



local function index_cond(key, cond, t)
  local index = {}
  for idx, value in ipairs(t) do
    index[value[key]] = value
  end
  return index[cond]
end

local function get_tasq()
  local team = api.get{"team"}
  local tasq = index_cond("name", "Tasq", team.teams)
  return tasq
end

local function get_me()
  local company = get_tasq()
  local index = {}
  for _, value in ipairs(company.members) do
    index[value.user.username] = value.user
  end
  return index["David Josephs"]
end

local function get_spaces()
  local team_id = get_tasq().id
  print("Finding spaces...")
  local path = "team/"..team_id.."/space?archived=false"
  local ret =  api.get{path}
  return ret["spaces"]
end

local function get_folders()
  local spaces = get_spaces()
  print("Finding folders...")
  local ret = {}
  for _, space in ipairs(spaces) do
    local resp = api.get{"space/"..space.id.."/folder?archived=false"}
    for _, r in ipairs(resp.folders) do
      ret[r.id] = r
    end
  end
  return ret
end
-- print(json.encode(get_folders()))

local function get_lists()
  local folders = get_folders()
  local spaces = get_spaces()
  print("Getting foldered lists...")
  local ret = {}
  for _, folder in pairs(folders) do
    local path = "folder/"..folder.id.."/list?archived=false"
    local resp = api.get{path}
    if resp ~= nil then
      for _, r in ipairs(resp.lists) do
        ret[r.id] = r
      end
    end
  end
  print("Getting unfoldered lists...")
  for _, space in ipairs(spaces) do
    local path = "space/"..space.id.."/list?archived=false"
    local resp = api.get{path}
    if resp ~= nil then
      for _, r in ipairs(resp.lists) do
        ret[r.id] = r
      end
    end
  end
  return ret
end

local function get_tasks()
  local lists = get_lists()
  local ret = {}
  print("Getting tasks!")
  for id, _ in pairs(lists) do
    local path = "list/"..id.."/task?archived=false&subtasks=true"
    local resp = api.get{path}
    -- TODO Make async
    for _, value in pairs(resp.tasks) do
      if (type(value) == "table") then
        ret[value.id] = value
      end
    end
  end
  return ret
end



M.backend = {
  company = get_tasq,
  me = get_me,
  spaces = get_spaces,
  folders = get_folders,
  lists = get_lists,
  tasks = get_tasks
}

M.api = api

table.insert(M, "hamburger")

return M
