# cranburi restream

a docker compose project that uses ffmpeg to consume an RTMP stream (eg, reolink cam), and then re-streams it to a local webserver, or stream service (eg youtube live)


## setup the project

get an ubuntu server, clone the repo

```sh
git clone https://github.com/cranburi/cranburi-restream
cd cranburi-restream
```

copy the .env.dist file and update the variable values

```sh
mv .env.dist .env
```

run the setup script to provision the server

```sh
./scripts/setup/ubuntu22.sh
```

start the services
```sh
./scripts/start.sh
```

