Bootstrap a One Click Orgs development environment.

1. Install VirtualBox, version 4.0.12.
2. Install Ruby (1.9.2 or 1.8.7, doesn't really matter since we're only using it to bootstrap your environment).
3. Install Vagrant, version 0.7.8.
       sudo gem install -v 0.7.8 vagrant
3. Download bootstrap.rb to a new directory.
4. From the new directory run:
       ruby bootstrap.rb

VirtualBox:
http://www.virtualbox.org/wiki/Download_Old_Builds_4_0

Ruby:
  Windows:
  http://rubyinstaller.org/
  
  Linux:
  Install using your package manager. E.g., on Debian or Ubuntu:
  sudo apt-get install ruby
  
  Mac OS X:
  Ruby is already installed.
