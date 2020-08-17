#!/bin/bash

set -e # Exit on errors

if [ -n "$TMUX" ]; then
  export NESTED_TMUX=1
  export TMUX=''
fi

if [ ! $REACT_APP_DIR ]; then export REACT_APP_DIR=$HOME/workspace/blog-in-react; fi

cd $REACT_APP_DIR

tmux new-session  -d -s react-app
tmux set-environment -t react-app -g REACT_APP_DIR $REACT_APP_DIR

tmux new-window     -t react-app -n 'server'
tmux send-key       -t react-app 'cd $REACT_APP_DIR'      Enter 'npm start'                                       Enter

tmux new-window     -t react-app -n 'vim'
tmux send-key       -t react-app 'cd $REACT_APP_DIR'      Enter 'vim .'                                           Enter

tmux new-window     -t react-app -n 'ack'
tmux send-key       -t react-app 'cd $REACT_APP_DIR'      Enter 'reset'                                           Enter

if [ -z "$NESTED_TMUX" ]; then
  tmux -2 attach-session -t react-app
else
  tmux -2 switch-client -t react-app
fi
