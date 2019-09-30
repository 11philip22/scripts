if nc -z $1 $2; then
   exec nc $1 $2  # connect directly
else
   exec ssh m1006 nc $1 $2 # use proxy
fi
