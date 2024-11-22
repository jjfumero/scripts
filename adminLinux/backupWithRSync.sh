
print_help() {
	echo "Usage:" 
	echo "   ./backupWithRSync.sh <orig> <dest>"
}

if [ -z "$1" ]; then
  echo "Error: First argument (orig folder) is missing."
  print_help
  exit 1
fi

if [ -z "$2" ]; then
  echo "Error: Second argument (dest folder) is missing."
  print_help
  exit 1
fi

orig=$1
dest=$2
echo "[INFO] rsync -avhW --delete-before --no-compress --progress $1 $2"
rsync -avhW --delete-before --no-compress --progress $1 $2
