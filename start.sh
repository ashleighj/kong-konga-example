# KONG SETTINGS
export KONG_DB_NAME=db_kong
export KONG_DB_USERNAME=konguser
export KONG_DB_PASSWORD=kongpassword
export KONG_DB_HOST=db
export KONG_DB_PORT=5432

export KONG_DATABASE=postgres
export KONG_PROXY_ACCESS_LOG=/dev/stdout
export KONG_ADMIN_ACCESS_LOG=/dev/stdout
export KONG_PROXY_ERROR_LOG=/dev/stderr
export KONG_ADMIN_ERROR_LOG=/dev/stderr
export KONG_ADMIN_LISTEN=0.0.0.0:8001,\ 0.0.0.0:8444\ ssl

export KONG_PROXY_PORT=8000
export KONG_PROXY_SSL_PORT=8443
export KONG_PROXY_ADMIN_API_PORT=8001
export KONG_PROXY_ADMIN_SSL_API_PORT=8444

# KONGA SETTINGS
export KONGA_DB_NAME=db_konga
export KONGA_DB_USERNAME=kongauser
export KONGA_DB_PASSWORD=kongapassword
export KONGA_DB_HOST=db
export KONGA_DB_PORT=5432

export KONGA_TOKEN_SECRET=some-secret-token
export KONGA_ENV=development
export KONGA_PORT=9000

printf "\n\n ----- Create network ----- \n\n"

docker network create kong-net

printf "\n\n ----- Build/run db, migrations, kong ----- \n\n"

docker-compose up -d --build db kong-migrations kong

printf "\n\n Waiting for kong.... \n\n"

sleep 5

echo " ....Done waiting"

printf "\n\n ----- TEST kong admin api ----- \n\n"

curl -i http://localhost:8001/

printf "\n\n ----- Build/run konga ----- \n\n"

docker-compose up --build -d konga

printf "\n\n ---> Add Admin API route... \n\n"

curl --location --request POST 'http://localhost:8001/services/admin-api/routes' \
--header 'Content-Type: application/json' \
--data-raw '{
    "paths": ["/admin-api"]
}'

printf "\n\n ---> Show consumers so you can get the consumer id... ----- \n\n"

curl --location --request GET 'http://localhost:8001/consumers/'