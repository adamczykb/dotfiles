{
  config,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      # remap prefix from 'C-b' to 'C-a'
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      # split panes using | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      set -g mouse on

      ######################
      ### DESIGN CHANGES ###
      ######################

      # loud or quiet?
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      #  modes
      setw -g clock-mode-colour colour5
      setw -g mode-style 'fg=colour1 bg=colour18 bold'

      # panes
      set -g pane-border-style 'fg=colour19 bg=colour0'
      set -g pane-active-border-style 'bg=colour0 fg=colour9'

      # statusbar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'bg=colour18 fg=colour137 dim'
      set -g status-left \'\'
      set -g status-right '#[fg=colour233,bg=colour19] %d/%m #[fg=colour233,bg=colour8] %H:%M:%S '
      set -g status-right-length 50
      set -g status-left-length 20

      setw -g window-status-current-style 'fg=colour1 bg=colour19 bold'
      setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '

      setw -g window-status-style 'fg=colour9 bg=colour18'
      setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

      setw -g window-status-bell-style 'fg=colour255 bg=colour1 bold'

      # messages
      set -g message-style 'fg=colour232 bg=colour16 bold'

      set -g default-terminal "screen-256color"
    '';
  };
}
