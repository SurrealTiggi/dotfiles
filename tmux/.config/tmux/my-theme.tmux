#!/usr/bin/env bash
#==============================================================================
# A tmux theme inspired by tmux-power (https://github.com/wfxr/tmux-power)
# Basically just adding bits I was missing
#==============================================================================

# $1: option
# $2: default value
tmux_get() {
  local value="$(tmux show -gqv "$1")"
  [ -n "$value" ] && echo "$value" || echo "$2"
}

# $1: option
# $2: value
tmux_set() {
  tmux set-option -gq "$1" "$2"
}

################################## Options ####################################
# See TODO.md for code organization tasks
get_options() {
  right_arrow_icon=$(tmux_get '@my_tmux_right_arrow_icon' '')
  left_arrow_icon=$(tmux_get '@my_tmux_left_arrow_icon' '')
  right_rounded_icon=$(tmux_get '@my_tmux_right_rounded_icon' '')
  left_rounded_icon=$(tmux_get '@my_tmux_left_rounded_icon' '')
  folder_icon=$(tmux_get '@my_tmux_folder_icon' '')
  magnifying_icon=$(tmux_get '@my_tmux_magnifying_icon' ' ')
  tree_icon=$(tmux_get '@my_tmux_tree_icon' '󰐅')
  upload_speed_icon=$(tmux_get '@my_tmux_upload_speed_icon' '')
  download_speed_icon=$(tmux_get '@my_tmux_download_speed_icon' '')
  session_icon="$(tmux_get '@my_tmux_session_icon' '󰍹')"
  user_icon="$(tmux_get '@my_tmux_user_icon' '')"
  time_icon="$(tmux_get '@my_tmux_time_icon' ' ')"
  date_icon="$(tmux_get '@my_tmux_date_icon' ' ')"
  cpu_icon="$(tmux_get '@my_tmux_cpu_icon' '󰻠')"
  memory_icon="$(tmux_get '@my_tmux_memory_icon' '󰍛')"
  prefix_highlight_pos=$(tmux_get @my_tmux_prefix_highlight_pos)
  time_format=$(tmux_get @my_tmux_time_format '%T')
  date_format=$(tmux_get @my_tmux_date_format '%F')
  show_upload_speed="$(tmux_get @my_tmux_show_upload_speed false)"
  show_download_speed="$(tmux_get @my_tmux_show_download_speed false)"
  # short for Theme-Colour
  TC=$(tmux_get '@my_tmux_theme' 'night')
  case $TC in
      'night' )
          TC='#FF9F41'  # Oasis night secondary color
          ;;
      'gold' )
          TC='#ffb86c'
          ;;
      'redwine' )
          TC='#b34a47'
          ;;
      'moon' )
          TC='#00abab'
          ;;
      'forest' )
          TC='#228b22'
          ;;
      'violet' )
          TC='#9370db'
          ;;
      'snow' )
          TC='#fffafa'
          ;;
      'coral' )
          TC='#ff7f50'
          ;;
      'sky' )
          TC='#87ceeb'
          ;;
      'default' ) # Useful when your term changes colour dynamically (e.g. pywal)
          TC='colour3'
          ;;
  esac
}
get_options

############################## Colors #########################################
# Oasis Night theme colors
set_colors() {
  # Main colors
  FG="#E0E4F8"
  PRIMARY="#cd5c5c"
  SECONDARY="#FF9F41"
  PREFIX="#87CEEB"

  # Surfaces
  CORE="#0D0D1A"
  MANTLE="#06060E"
  SURFACE="#262633"

  # Accent colors
  RED="#FFA0A0"
  ORANGE="#FFA852"
  YELLOW="#F0E68C"
  DARKYELLOW="#BDB76B"
  GREEN="#30bc73"
  TEAL="#8FD1C7"
  DARKTEAL="#3b9184"
  BLUE="#87CEEB"
  INDIGO="#B499FF"

  # Cool-toned gradient for right status bar (darkest to lightest)
  # Using teal/blue shades - dark at edges, lighter in middle
  GRADIENT_DARKEST="#1A3A3A"   # Darkest teal for date (rightmost edge)
  GRADIENT_DARK="#2A5555"      # Dark teal for time
  GRADIENT_MEDIUM="#3A7070"    # Medium teal for CPU/Mem (lightest - center)
  GRADIENT_LIGHT="#2A5555"     # Light teal for weather (getting darker again)

  # Legacy grayscale (for compatibility)
  G01=$CORE
  G02=$MANTLE
  G03=$MANTLE
  G04=$SURFACE
  G05=$SURFACE
  G06=$SURFACE
  G07=#444444

  BG="$SURFACE"
}
set_colors

# Status options
tmux_set status on

# Basic status bar colors
tmux_set status-fg "$FG"
tmux_set status-bg "$BG"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$BG"
tmux_set @prefix_highlight_bg "$FG"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$BG,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$TC]#[bg=$BG]$left_arrow_icon#[bg=$TC]#[fg=$BG]"
tmux_set @prefix_highlight_output_suffix "#[fg=$TC]#[bg=$BG]$right_arrow_icon"

set_segments() {
  # Right status bar segments intentionally left empty
  :
}
set_segments

################################ Status Bar ###################################
set_left() {
  tmux_set status-left-bg "$BG"
  tmux_set status-left-fg "$FG"
  tmux_set status-left-length 150

  # Mode indicator - priority: ZOOM > SELECT > COMMAND > NORMAL
  # ZOOM (teal) when window is zoomed
  # SELECT (green) when in tree-mode or client-mode (picking sessions)
  # COMMAND (blue) when prefix is pressed
  # NORMAL (coral/red) otherwise
  LS="#[fg=$CORE,bg=#{?window_zoomed_flag,$TEAL,#{?#{||:#{==:#{pane_mode},tree-mode},#{==:#{pane_mode},client-mode}},$GREEN,#{?client_prefix,$PREFIX,$PRIMARY}}},bold]"
  LS="$LS #{?window_zoomed_flag,$magnifying_icon ZOOM,#{?#{||:#{==:#{pane_mode},tree-mode},#{==:#{pane_mode},client-mode}},$tree_icon SELECT,#{?client_prefix,COMMAND,NORMAL}}} "

  # Arrow transition from mode to session segment
  LS="$LS#[fg=#{?window_zoomed_flag,$TEAL,#{?#{||:#{==:#{pane_mode},tree-mode},#{==:#{pane_mode},client-mode}},$GREEN,#{?client_prefix,$PREFIX,$PRIMARY}}},bg=$MANTLE]$right_arrow_icon"

  # Session name - orange text on black background (all sessions)
  LS="$LS#[fg=$SECONDARY,bg=$MANTLE] $session_icon #S "
  LS="$LS#[fg=$MANTLE,bg=$PRIMARY]$right_arrow_icon"

  # Current folder (show ~ for home, truncate to 10 chars with ellipsis)
  LS="$LS#[fg=$CORE,bg=$PRIMARY,bold] $folder_icon #(d=\"#{pane_current_path}\"; [ \"\$d\" = \"$HOME\" ] && echo '~' || { n=\$(basename \"\$d\"); [ \${#n} -le 15 ] && echo \"\$n\" || echo \"\${n:0:8}…\${n: -6}\"; }) #[fg=$PRIMARY,bg=$BG,nobold]$right_arrow_icon"

  tmux_set status-left "$LS"
}

set_right() {
  tmux_set status-right-bg "$BG"
  tmux_set status-right-fg "$FG"
  tmux_set status-right-length 1000

  RS=""

  tmux_set status-right "$RS"
}

set_left
set_right

################################### Misc ######################################
# Window status - rounded pills style (inspired by oasis)
# Inactive windows
tmux_set window-status-format "\
#[fg=$MANTLE,bg=$BG]$left_rounded_icon\
#[bg=$MANTLE,fg=$PRIMARY] #I#{?#{!=:#{window_name},Window}, #W,} \
#[fg=$MANTLE,bg=$BG]$right_rounded_icon"

# Active window with zoom indicator
tmux_set window-status-current-format "\
#[fg=$SECONDARY,bg=$BG]$left_rounded_icon\
#[bg=$SECONDARY,fg=$CORE,bold] #I#{?#{!=:#{window_name},Window}, #W,}#{?window_zoomed_flag, $magnifying_icon,} \
#[fg=$SECONDARY,bg=$BG]$right_rounded_icon"

# Window separator
tmux_set window-status-separator ""

# Window status alignment - use absolute-centre to keep window list fixed regardless of left/right status bar width
tmux_set status-justify absolute-centre

# Current window status
tmux_set window-status-current-statys "fg=$TC,bg=$BG"

# Pane border
tmux_set pane-border-style "fg=$G07,bg=default"

# Active pane border
tmux_set pane-active-border-style "fg=$TC,bg=$BG"

# Pane number indicator
tmux_set display-panes-colour "$G07"
tmux_set display-panes-active-colour "$TC"

# Clock mode
tmux_set clock-mode-colour "$TC"
tmux_set clock-mode-style 24

# Message
tmux_set message-style "fg=$TC,bg=$BG"

# Command message
tmux_set message-command-style "fg=$TC,bg=$BG"

# Copy mode highlight
tmux_set mode-style "bg=$TC,fg=$FG"

#################################### Run ######################################
