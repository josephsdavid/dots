function plan_binds()
    binds = Keybind[]

    keybinds = [
        mod4(:slash) => spawn("/home/david/scripts/menus/system-menu.sh"),
        mod4(:Shift, :q) => spawn("/home/david/scripts/menus/locker.sh"),
        mod4(:Shift, :r) => :reload,
        mod4(:x) => :close,
        mod4(:w) => :remove,
        mod4(:Shift, :x) => :close_or_remove,
        mod4(:d) => chain("emit_hook dmenu", spawn("rofi -show drun -columns 3")),
        mod4(:Shift, :Return) => spawn(:alacritty),
        mod4(:Shift, :v) => spawn(:firefox),
        :XF86AudioRaiseVolume => spawn("/home/david/scripts/utilities/dunst_vol", :up),
        :XF86AudioLowerVolume =>
            spawn("/home/david/scripts/utilities/dunst_vol", :down),
        :XF86AudioMute => spawn("/home/david/scripts/utilities/dunst_vol", :mute),
        :XF86MonBrightnessUp =>
            spawn("/home/david/scripts/utilities/dunst_bright", :up),
        :XF86MonBrightnessDown =>
            spawn("/home/david/scripts/utilities/dunst_bright", :down),
        mod4(:Alt, :Down) => chain(spawn(:playerctl, "play-pause")),
        mod4(:Alt, :Left) => chain(spawn(:playerctl, "previous")),
        mod4(:Alt, :Right) => chain(spawn(:playerctl, "next")),
        :XF86AudioPlay => chain(spawn(:playerctl, "play-pause")),
        :XF86AudioPrev => chain(spawn(:playerctl, "previous")),
        :XF86AudioNext => chain(spawn(:playerctl, "next")),
        mod4(:Shift, :p) => spawn("/home/david/scripts/utilities/screenshot"),
        mod4(:Shift, :f) => spawn("/home/david/scripts/utilities/recorder"),
        mod4(:Alt, :f) =>
            chain(spawn(:pkill, :ffmpeg), spawn("notify-send", "Recording stopped!")),
        mod4(:Left) => focus(:left),
        mod4(:h) => focus(:left),
        mod4(:Right) => focus(:right),
        mod4(:l) => focus(:right),
        mod4(:Up) => focus(:up),
        mod4(:k) => focus(:up),
        mod4(:Down) => focus(:down),
        mod4(:j) => focus(:down),
        mod4(:Shift, :h) => move_across_monitors("l"),
        mod4(:Shift, :Left) => move_across_monitors("l"),
        mod4(:Shift, :j) => move_across_monitors("d"),
        mod4(:Shift, :Down) => move_across_monitors("d"),
        mod4(:Shift, :k) => move_across_monitors("u"),
        mod4(:Shift, :Up) => move_across_monitors("u"),
        mod4(:Shift, :l) => move_across_monitors("r"),
        mod4(:Shift, :Right) => move_across_monitors("r"),
        mod4(:u) => _split(:bottom, 0.5),
        mod4(:o) => _split(:right, 0.5),
        mod4(:Control, :space) => _split(:explode),
        mod4(:Control, :h) => resize(:left, "+0.05"),
        mod4(:Control, :j) => resize(:down, "+0.05"),
        mod4(:Control, :k) => resize(:up, "+0.05"),
        mod4(:Control, :l) => resize(:right, "+0.05"),
        mod4(:t) => "floating toggle",
        mod4(:f) => "fullscreen toggle",
        mod4(:p) => "pseudotile toggle",
        mod4(:Shift, :t) => spawn("/home/david/.config/herbstluftwm/bin/floatsingle"),
        # I cba
        mod4(:space) => "chain cc or , and . compare tags.focus.curframe_wcount = 2 . cycle_layout +1 vertical horizontal max vertical grid , cycle_layout +1 cc emit_hook layout_changed",
        mod4(:BackSpace) => :cycle_monitor,
        mod4(:Tab) => "cycle_all +1",
        mod4(:Shift, :Tab) => "cycle_all -1",
        mod4(:c) => "cycle",
        mod4(:Shift, :c) => "cycle -1",
        "Mod1-Tab" => spawn("/home/david/.config/herbstluftwm/bin/switcher.sh"),
        mod4(:i) => "jumpto urgent",
        mod4(:grave) => spawn("/home/david/.config/herbstluftwm/bin/scratchpad"),
        mod4(:s) => chain("emit_hook window_search", spawn("rofi -show window")),
        mod4(:m) => spawn("/home/david/.config/herbstluftwm/bin/minimize +1"),
        mod4(:Control, :m) => spawn("/home/david/.config/herbstluftwm/bin/minimize -1"),
        mod4(:Shift, :m) => spawn("/home/david/.config/herbstluftwm/bin/minimize"),
        mod4(:Alt, :m) => spawn("/home/david/.config/herbstluftwm/bin/minimize 0"),
        mod4(:b) => spawn("/home/david/.config/herbstluftwm/bin/maximize"),
        mod4(:Shift, :space) => spawn("/home/david/scripts/utilities/day-night.sh"),
        mod4(:Shift, :g) => "cycle_value frame_gap 0 4 16 32 48 64"
    ]
    pushbind!(binds, Keybind.(Tag.(1:9)))
    pushbind!(binds, Keybind.(keybinds))
    @show binds
    return binds

end



set_binds() = bind.(plan_binds())

