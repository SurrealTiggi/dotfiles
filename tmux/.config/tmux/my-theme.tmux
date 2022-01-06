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
# TODO: Move colors to #Colors
# TODO: configure $config_dir
# TODO: Consolidate tmux_get|tmux_set into helpers()
get_options() {
  right_arrow_icon=$(tmux_get '@my_tmux_right_arrow_icon' '')
  left_arrow_icon=$(tmux_get '@my_tmux_left_arrow_icon' '')
  upload_speed_icon=$(tmux_get '@my_tmux_upload_speed_icon' '')
  download_speed_icon=$(tmux_get '@my_tmux_download_speed_icon' '')
  session_icon="$(tmux_get '@my_tmux_session_icon' '')"
  user_icon="$(tmux_get '@my_tmux_user_icon' 'גּ')"
  time_icon="$(tmux_get '@my_tmux_time_icon' ' ')"
  date_icon="$(tmux_get '@my_tmux_date_icon' ' ')"
  prefix_highlight_pos=$(tmux_get @my_tmux_prefix_highlight_pos)
  time_format=$(tmux_get @my_tmux_time_format '%T')
  date_format=$(tmux_get @my_tmux_date_format '%F')
  show_upload_speed="$(tmux_get @my_tmux_show_upload_speed false)"
  show_download_speed="$(tmux_get @my_tmux_show_download_speed false)"
  # short for Theme-Colour
  TC=$(tmux_get '@my_tmux_theme' 'gold')
  case $TC in
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
set_colors() {
  G01=#080808 #232
  G02=#121212 #233
  G03=#1c1c1c #234
  G04=#262626 #235
  G05=#303030 #236
  G06=#3a3a3a #237
  G07=#444444 #238
  G08=#4e4e4e #239
  G09=#585858 #240
  G10=#626262 #241
  G11=#6c6c6c #242
  G12=#767676 #243

  FG="$G10"
  BG="$G04"
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

################################# Elements ####################################
set_segments() {
  date_segment="#[fg=$G04,bg=$TC] $date_icon $date_format "
  time_segment="#[fg=$TC,bg=$G06] $time_icon $time_format "
  systats_segment="#[fg=$TC,bg=$G05] ﬙ #(~/.config/tmux/scripts/cpu.sh)#[fg=$TC,bg=$G05]  #(~/.config/tmux/scripts/mem.sh)#[fg=$TC,bg=$G05]  #(~/.config/tmux/scripts/swap.sh)#[fg=$TC,bg=$G05]  #(~/.config/tmux/scripts/loadavg.sh) "
  weather_segment="#[fg=$TC,bg=$G05] #(~/.config/tmux/scripts/weather.sh)"
}
set_segments

################################ Status Bar ###################################
set_left() {
  tmux_set status-left-bg "$G04"
  tmux_set status-left-fg "G12"
  tmux_set status-left-length 150
  user=$(whoami)

  LS="#[fg=$G04,bg=$TC,bold] $user_icon $user #[fg=$TC,bg=$G06,nobold]$right_arrow_icon#[fg=$TC,bg=$G06] $session_icon #S "
  if "$show_upload_speed"; then
      LS="$LS#[fg=$G06,bg=$G05]$right_arrow_icon#[fg=$TC,bg=$G05] $upload_speed_icon #{upload_speed} #[fg=$G05,bg=$BG]$right_arrow_icon"
  else
      LS="$LS#[fg=$G06,bg=$BG]$right_arrow_icon"
  fi
  if [[ $prefix_highlight_pos == 'L' || $prefix_highlight_pos == 'LR' ]]; then
      LS="$LS#{prefix_highlight}"
  fi
  tmux_set status-left "$LS"
}

set_right() {
  tmux_set status-right-bg "$G04"
  tmux_set status-right-fg "$G12"
  tmux_set status-right-length 1000
  r1_separator="#[fg=$TC,bg=$G06]$left_arrow_icon"
  r2_separator="#[fg=$G06,bg=$G05]$left_arrow_icon"
  r3_separator="#[fg=$G05,bg=$BG]$left_arrow_icon"
  RS="$r3_separator$weather_segment$systats_segment$r2_separator$time_segment$r1_separator$date_segment"
  if [[ $prefix_highlight_pos == 'R' || $prefix_highlight_pos == 'LR' ]]; then
      RS="#{prefix_highlight}$RS"
  fi
  tmux_set status-right "$RS"
}

set_left
set_right

################################### Misc ######################################
# Window status
tmux_set window-status-format " #I:#W#F "
tmux_set window-status-current-format "#[fg=$BG,bg=$G06]$right_arrow_icon#[fg=$TC,bold] #I:#W#F #[fg=$G06,bg=$BG,nobold]$right_arrow_icon"

# Window separator
tmux_set window-status-separator ""

# Window status alignment
tmux_set status-justify centre

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
