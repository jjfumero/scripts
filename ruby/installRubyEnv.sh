#!/bin/bash

## Ruby Env: manage different ruby versions (like perlbrew and pythonbrew)

git clone git://github.com/sstephenson/rbenv.git .rbenv 
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile 
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile 
exec $SHELL 

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build 
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile 
exec $SHELL

