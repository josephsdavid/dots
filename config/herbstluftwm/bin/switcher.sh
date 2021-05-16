#!/usr/bin/env bash
set -e
# A simple script for window maximization and window switching.
# Running this the first time script will:
#
#  1. remember the current layout
#  2. squeeze all windows into one frame using the layout defined in the first
#     argument (defaulting to max layout).
#  3. and during that, keeping the window focus
#
# Running this script again will:
#
#  1. restore the original layout
#  2. (again keeping the then current window focus)
#
# If you call this script with "grid", then you obtain a window switcher,
# similar to that of Mac OS X.
mode=${1:-grid} # just some valid layout algorithm name

# Initialise
herbstclient get_attr tags.focus.my_og_layout 1>/dev/null 2>/dev/null || \
  herbstclient new_attr string tags.focus.my_og_layout

layout=$(herbstclient dump)
cmd=(
# remember which client is focused
substitute FOCUS clients.focus.winid chain
. lock
. or : and # if there is more than one frame, then don't restore, but maximize again!
           , compare tags.focus.frame_count = 1
           # if we have such a stored layout, then restore it, else maximize
           , compare tags.focus.my_og_layout != ""
           , substitute STR tags.focus.my_og_layout load STR
           # remove the stored layout
           , set_attr tags.focus.my_og_layout ""
     : chain # save the current layout in the attribute
             , set_attr tags.focus.my_og_layout "$layout"
             # force all windows into a single frame in max layout
             , load "(clients $mode:0 )"
# both load commands accidentally change the window focus, so restore the
# window focus from before the "load" command
. jumpto FOCUS
. unlock
)
herbstclient emit_hook layout_changed
herbstclient "${cmd[@]}"

