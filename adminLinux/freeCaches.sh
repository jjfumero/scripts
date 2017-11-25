#!/bin/bash
sync

# To free pagecache
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'

# To free dentries and inodes
sudo sh -c 'echo 2 >/proc/sys/vm/drop_caches'

# To free pagecache, dentries and inodes
sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'

