# Host
hostname "localhost"
echo "localhost" > /etc/hostname

# Java
echo "get oracle-java7-installer"
mkdir -p /root/.local/share
apt-get install software-properties-common -y
add-apt-repository ppa:webupd8team/java
apt-get update
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get install oracle-java7-installer -y
apt-get install oracle-java7-set-default -y
echo "export JAVA_HOME=/usr/lib/jvm/java-7-oracle" > /etc/profile.d/java.sh
source /etc/profile

# Hadoop
cd /opt
echo "wget hadoop"
wget -q http://apache.stu.edu.tw/hadoop/core/hadoop-2.5.1/hadoop-2.5.1.tar.gz
tar -xzf hadoop-2.5.1.tar.gz
chown -R vagrant hadoop-2.5.1
chmod a+rwx hadoop-2.5.1
ln -s hadoop-2.5.1 hadoop

# Standalone Mode
echo "export HADOOP_HOME=/opt/hadoop" > /etc/profile.d/hadoop.sh
echo "export PATH=\$PATH:\$HADOOP_HOME/bin" >> /etc/profile.d/hadoop.sh
echo "export HADOOP_PREFIX=\$HADOOP_HOME" >> /etc/profile.d/hadoop.sh
echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> /etc/profile.d/hadoop.sh
echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> /etc/profile.d/hadoop.sh
echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> /etc/profile.d/hadoop.sh

# Pseudo-Distributed Mode
echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> /etc/profile.d/hadoop.sh
echo "export HADOOP_YARN_HOME=\$HADOOP_HOME" >> /etc/profile.d/hadoop.sh
echo "export YARN_CONF_DIR=\$HADOOP_CONF_DIR" >> /etc/profile.d/hadoop.sh
source /etc/profile
cd $HADOOP_CONF_DIR
cp /vagrant/script/*.xml .
sed -i 's/${JAVA_HOME}/\/usr\/lib\/jvm\/java-7-oracle/' hadoop-env.sh

# HDFS
cd $HADOOP_HOME
mkdir dfs
mkdir dfs/name
mkdir dfs/data
chown -R vagrant dfs

# Run as user vagrant
su -c "source /vagrant/ssh-hdfs.sh" vagrant
