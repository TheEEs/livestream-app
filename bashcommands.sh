sudo turnserver -L 0.0.0.0 -p 3478 -X 'YOUR EXTERNAL IP ADDRESS' \
    -r ream_name -a -f --min-port 50000 --max-port 50100 \
    --dh-file=/etc/turnserver/dhp.pem --no-tls --no-dtls   \
    --cert=<your_certificate_file> \
    --pkey=<your_private_key_file> \
    --server-name=<optional> --relay-ip=<your network interface you want the relay server to use>


