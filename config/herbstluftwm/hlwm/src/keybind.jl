struct Keybind{L, R}
    lhs::L
    rhs::R
end

(k::Keybind)() = cmd(hc(:keybind,k.lhs, k.rhs))

function Keybind(p::Pair)
    return Keybind(p...)
end

function Keybind(t::Tag{L, R}) where {L, R}
    return Keybind.([
        mod4(t.key) => use_index(t.name)
        mod4("Shift", t.key) => move_index(t.name)
    ])
end

bind(k::Keybind) = run(k(); wait = false)

pushbind!(binds::Vector{Keybind}, k::Keybind) = push!(binds, k)
function pushbind!(binds::Vector{Keybind}, k::Vector)
    for kk in k
        pushbind!(binds, kk)
    end
end
