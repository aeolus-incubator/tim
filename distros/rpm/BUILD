starting in the root directory of the project, if you are using:
* rvm - cd to tim/, allow rvm to bundle everything for you
* rbenv - point your environment to your preferred ruby 1.9 setup
* system - make sure you are on ruby 1.9, run bundle install --path
  bundle

yum install mock
sudo /usr/sbin/usermod -a -G mock $USER
edit /etc/mock/fedora-18-x86_64.cfg (or whatever your arch) to have (at end):
[fg-temp]
name=fg-temp
baseurl=http://slinabery.fedorapeople.org/factory-girl-temp-repo/
enabled=1
gpgcheck=0

"""
cd distros/rpm
./build
