function make_leader(leader)
  local function ret(s)
    return leader .. s
  end
  return ret
end

function make_mod(leader)
  local function ret(s)
    return "<"..leader.."-" .. s..">"
  end
  return ret
end

M = {}

local mappings = {}

mappings.leader = make_leader("<leader>")
mappings.swapleader = make_leader(mappings.leader("m"))
mappings.peekleader = make_leader(mappings.leader("p"))
mappings.refactorleader = make_leader(mappings.leader("r"))
mappings.docsleader = make_leader(mappings.leader("n"))
mappings.commentleader = make_leader(mappings.leader("c"))
mappings.vcommentleader = make_leader(mappings.leader("v"))
mappings.actionleader = make_leader(mappings.leader("c"))
mappings.telescopeleader = make_leader(mappings.leader("f"))
mappings.troubleleader = make_leader(mappings.leader("x"))
mappings.zeplleader = make_leader(mappings.leader("s"))
mappings.C = make_mod("c")
mappings.A = make_mod("a")
mappings.S  = make_mod("s")
mappings.hopleader =  make_leader(mappings.leader("h"))
mappings.go = make_leader("g")
mappings.tableader = make_leader(mappings.leader("t"))
mappings.bufferleader = make_leader(mappings.leader("b"))
mappings.norgleader = make_leader(mappings.leader('o'))



M.mappings = mappings
M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }


return M
