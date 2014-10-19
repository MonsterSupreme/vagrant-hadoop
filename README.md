vagrant-hadoop
==============

Using Vagrant to build an Ubuntu 14.04 VM with Hadoop configured as Pseudo-Distributed Mode.

Steps:

- `git clone https://github.com/MonsterSupreme/vagrant-hadoop.git` or download and unzip the ZIP file.
- `mkdir ~/opt`, make an `opt` directory under your Home Directory.
- `cd vagrant-hadoop`
- `vagrant up`, and wait for several minutes for downloading the Ubuntu box, repository update, JDK, and Hadoop.
- `vagrant ssh hadoop` to ssh the VM.

Everytime after you `vagrant up` the VM, please:

- `cd $HADOOP_HOME`
- `sbin/start-dfs.sh`
- `sbin/start-yarn.sh`

Then just do whatever you want, for example:

- `cd $HADOOP_HOME`
- `bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.5.1.jar pi 16 10000`

Everytime before you want to `vagrant halt` the VM, please:

- `cd $HADOOP_HOME`
- `sbin/stop-yarn.sh`
- `sbin/stop-dfs.sh`

That's it.
