
pid=$1
CPIDS=`pgrep -P $pid` # gets pids of child processes
kill -9 $pid
for cpid in $CPIDS ; do 
	echo "Killing process: $cpid"
	kill -9 $cpid ; 
done
