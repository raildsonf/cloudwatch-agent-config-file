#!/bin/bash
yum install httpd git -y
hostname > /var/www/html/index.html
systemctl restart httpd
systemctl enable httpd

yum install amazon-cloudwatch-agent -y
git clone https://github.com/raildsonf/cloudwatch-agent-config-file.git
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
mv cloudwatch-agent-config-file/amazon-cloudwatch-agent.json  /opt/aws/amazon-cloudwatch-agent/etc/
nohup /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s &
sleep 10
systemctl enable amazon-cloudwatch-agent
