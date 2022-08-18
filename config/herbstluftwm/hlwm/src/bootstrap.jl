function delim_str(init = "", delim = " ")
    return (s...) -> reduce((x, y) -> "$(x)$(delim)$(y)", [s...]; init)
end

const herbst_exports = [
    (:mod4, :-),
    :use_index,
    :move_index,
    :keybind,
    :spawn,
    (:chain, " . "),
    :focus,
    # :split,
    :resize,
    :lock,
    :unlock,
    :rotate,
]

for f in herbst_exports
    if f isa Tuple
        delim = last(f)
        f = first(f)
    else
        delim = " "
    end
    f_str = string(f)
    @eval begin
        const $(f) = delim_str($(f_str), $(delim))
    end
end

const _split = delim_str(:split)
const hc = delim_str(:herbstclient)

move_across_monitors(direction) = chain(
    :lock,
    :shift_to_monitor,
    "-$(direction)",
    :focus_monitor,
    "-$(direction)",
    "emit_hook layout_changed",
    :unlock,
)
