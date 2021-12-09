#!/bin/sh
#Default args
path=${1:-"/home/sabah/Desktop/development"}
export_creds='export GOOGLE_APPLICATION_CREDENTIALS="/Users/uddins/Desktop/dev-pipeline.json"'
# Session Name
# session="some_session"
session=${2:-"some_session"}

#check if session exists
SESSIONEXISTS=$(tmux list-sessions | grep $session)
if [ "$SESSIONEXISTS" != "" ]
then
    read -r -p "Session alaready :$session: exists, drop and recreate? [y/n]" response
    # if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    if [ $response="y" ]
    then echo killed session :$session; $(tmux kill-session -t $session)
    else echo Did not kill session; exit 1
    fi
fi
tmux new-session -d -s $session
echo Created session :$session

# First window
tmux rename-window -t 0 'Main'
tmux send-keys -t  $session:Main.0 "tmux split-window -v" ENTER
sleep 3
tmux send-keys -t  $session:Main.1 "tmux resize-pan -D 15" ENTER
#cd to directory and open nvim
tmux send-keys -t  $session:Main.0 "cd $path && nvim" ENTER
tmux send-keys -t  $session:Main.0 ":NT" ENTER
tmux send-keys -t  $session:Main.1 "cd $path" ENTER
#if there is virtualenv, activate it
tmux send-keys -t  $session:Main.1 "source venv/bin/activate && $export_creds" ENTER
echo configured first window


#Second window
tmux new-window -t $session:1 -n 'Secondary'
tmux send-keys -t  $session:Secondary.0 "tmux split-window -v" ENTER
sleep 3
tmux send-keys -t  $session:Secondary.1 "tmux resize-pan -D 15" ENTER
tmux send-keys -t  $session:Secondary.0 "nvim" ENTER
tmux send-keys -t  $session:Secondary.0 ":NT" ENTER
# echo configured second window
# sleep 2
#attach to session
tmux attach-session -t $SESSION:0.0
