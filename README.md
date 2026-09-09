# hend-api

Laravel API running in Docker (PHP-FPM + nginx + MySQL).

## Setup

```sh
cp .env.example .env
docker compose up -d --build
docker compose exec app composer install
docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate --seed
```

The API is then available at:

- https://localhost:4333 (self-signed certificate)
- http://localhost:8000 (plain HTTP, same app)

The certificate is self-signed, so your browser will warn once — accept it and
continue. With `curl`, pass `-k`.

MySQL is reachable from the host on port `6015` (database `hend_db`, user `hend_user`).

## Everyday commands

```sh
docker compose up -d        # start
docker compose down         # stop
docker compose logs -f app  # follow app logs
docker compose exec app bash
docker compose exec app php artisan migrate
```

## Regenerating the TLS certificate

The certificate is not in git. Generate one on a fresh clone (or when it expires):

```sh
openssl req -x509 -nodes -newkey rsa:2048 -days 3650 \
  -keyout docker/nginx/certs/nginx.key -out docker/nginx/certs/nginx.crt \
  -subj "/C=AM/ST=Yerevan/L=Yerevan/O=Hend/CN=localhost" \
  -addext "subjectAltName=DNS:localhost,DNS:hend-api.local,IP:127.0.0.1"
```

The `subjectAltName` matters — browsers reject certificates without it.

To wipe the database and start over:

```sh
docker compose down -v
```
