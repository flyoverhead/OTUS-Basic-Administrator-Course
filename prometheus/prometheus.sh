mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
sed -i '65s/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
yum install vim wget -y
wget https://github.com/prometheus/prometheus/releases/download/v2.26.0-rc.0/prometheus-2.26.0-rc.0.linux-amd64.tar.gz
useradd --no-create-home --shell /bin/false prometheus
mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus
tar -xvzf prometheus-2.26.0-rc.0.linux-amd64.tar.gz
cp prometheus-2.26.0-rc.0.linux-amd64/prometheus /usr/local/bin/
cp prometheus-2.26.0-rc.0.linux-amd64/promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
cp -r prometheus-2.26.0-rc.0.linux-amd64/consoles/ /etc/prometheus
cp -r prometheus-2.26.0-rc.0.linux-amd64/console_libraries/ /etc/prometheus
chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries
cp /vagrant/prometheus/prometheus.yml /etc/prometheus/
chown prometheus:prometheus /etc/prometheus/prometheus.yml
cp /vagrant/prometheus/prometheus.service /etc/systemd/system/
systemctl daemon-reload
systemctl start prometheus
systemctl status prometheus