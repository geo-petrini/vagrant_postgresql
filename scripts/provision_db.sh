echo "-------------------- updating package lists"
apt-get update

# gotta put this before the upgrade, b/c it reboots and then all commands are lost
echo "-------------------- installing postgres"
apt-get install postgresql-14 -y

# fix permissions
echo "-------------------- fixing listen_addresses on postgresql.conf"
sed -i "s/#listen_address.*/listen_addresses '*'/" /etc/postgresql/14/main/postgresql.conf

echo "-------------------- fixing postgres pg_hba.conf file"
# replace the ipv4 host line with the above line
cat >> /etc/postgresql/14/main/pg_hba.conf <<EOF
# Accept all IPv4 connections - FOR DEVELOPMENT ONLY!!!
host    all         all         0.0.0.0/0             md5
EOF

echo "-------------------- creating postgres vagrant role with password vagrant"
# Create Role and login
sudo su postgres -c "psql -c \"CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'\" "

echo "-------------------- creating wtm database"
# Create WTM database
sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant wtm"

echo "-------------------- upgrading packages to latest"
#apt-get upgrade -y
