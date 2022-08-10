#!/bin/bash

# MISP configuration
echo "Creating MISP to Sentinel integration configuration file"
cd /opt/security-api-solutions/Samples/MISP
sed -i "s/misp_key\s*=\s*.*$/misp_key = '$MISP_KEY'/" config.py
sed -i "s/misp_domain\s*=\s*.*$/misp_domain = '$MISP_DOMAIN'/" config.py
sed -i "s/'tenant'\s*:\s*.*,$/'tenant': '$TENANT',/" config.py
sed -i "s/'client_id'\s*:\s*.*,$/'client_id': '$CLIENT_ID',/" config.py
sed -i "s/'client_secret'\s*:\s*.*,$/'client_secret': '$CLIENT_SECRET',/" config.py
sed -i "s/targetProduct\s*=\s*.*$/targetProduct = '$TARGET_PRODUCT'/" config.py
sed -i "s/action\s*=\s*.*$/action = '$ACTION'/" config.py

# Start supervisord
echo "Starting supervisord"
cd /
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
