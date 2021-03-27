wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz
sudo useradd -rs /bin/false nodeusr
tar -xvzf node_exporter-1.1.2.linux-amd64.tar.gz
mv node_exporter-1.1.2.linux-amd64/node_exporter /usr/local/bin/
cp /vagrant/prometheus/node_exporter.service /etc/systemd/system/
systemctl daemon-reload
systemctl start node_exporter
