#!/bin/sh
#Default args
path=${1:-"/home/sabah/Desktop/development"}
export_creds='export GOOGLE_APPLICATION_CREDENTIALS="/Users/uddins/Desktop/dev-pipeline.json"'
session=${2:-"some_session"}

activate_venv="source venv/bin/activate"

# to_install="pip install jedi black pylint neovim"
to_install="pip install black pynvim"


#check if session exists
SESSIONEXISTS=$(tmux list-sessions | grep $session)
if [ "$SESSIONEXISTS" != "" ]
then
    read -r -p "Session alaready :$session: exists, drop and recreate? [y/n]" response
    # if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    if [ $response = "y" ]
    then echo killed session :$session; $(tmux kill-session -t $session)
    else echo Did not kill session; exit 1
    fi
fi

# Create new session
tmux new-session -d -s $session
echo Created session :$session

# First window, install necessary plugins needed for vim to function
tmux rename-window -t 0 'Main'

tmux send-keys -t  $session:Main.0 "cd $path && $activate_venv && $export_creds && $to_install; tmux split-window -v; nvim" ENTER
tmux send-keys -t  $session:Main.0 "NERDTreeToggle" ENTER

sleep 3
tmux send-keys -t  $session:Main.1 "cd $path && $activate_venv; tmux resize-pan -D 15" ENTER
echo configured first window


#Second window
tmux new-window -t $session:1 -n 'Secondary'
tmux send-keys -t  $session:Secondary.0 "tmux split-window -v; nvim" ENTER

tmux send-keys -t  $session:Secondary.0 "NERDTreeToggle" ENTER

sleep 3
tmux send-keys -t  $session:Secondary.1 "tmux resize-pan -D 15" ENTER
# sleep 2

#attach to session
tmux attach-session -t $SESSION:0.0

