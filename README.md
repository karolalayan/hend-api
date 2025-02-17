# Running the Application with HTTPS

## Generate SSL Certificates
```sh
mkdir -p docker/nginx/certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout docker/nginx/certs/nginx.key -out docker/nginx/certs/nginx.crt
