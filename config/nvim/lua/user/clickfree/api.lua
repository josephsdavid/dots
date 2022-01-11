local status_ok, https = pcall(require, "ssl.https")
if not status_ok then
  print("shit!")
  return
end

local status_ok, ltn12 = pcall(require, "ltn12")
if not status_ok then
  print("shit!")
  return
end

local status_ok, json = pcall(require, "json")
if not status_ok then
  print("shit!")
  return
end



local api = {
  headers = {["Authorization"] =  "SECRET!"}, -- MOVE THIS SOMEWHERE ELSE
  base_url = "https://api.clickup.com/api/v2",
  format_url = function(s)
    return api.base_url .. "/" .. s
  end,
  get = function (s)
    local url = api.format_url(s)
    local ret = {}
    local xx = https.request {
      url = url,
      headers = api.headers,
      method = "GET",
      sink = ltn12.sink.table(ret)
      }
      local response = table.concat(ret)
    return response
  end
}


-- local teams = api.get("team")
-- print(teams)

