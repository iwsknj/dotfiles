#!/bin/bash
# tmux split-window -v -p 30
# # tmux split-window -h -p 66
# tmux split-window -h -p 50

tmux split-window -v
tmux split-window -h
tmux resize-pane -D 15
tmux select-pane -t 1
