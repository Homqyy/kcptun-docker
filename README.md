# KCPTUN
KCPTUN is a fast and secure tunneling program for transferring data over the internet. It is based on the [KCP protocol](https://github.com/skywind3000/kcp). 

## Usage
This Dockerfile contains a script to run KCPTUN with the following environment variables: 
* `KCPTUN_TYPE` - either `server` or `client` (system, don't alter it)
* `KCPTUN_LISTEN` - the address to listen on (for server) 
* `KCPTUN_TARGET` - the target address (for server) 
* `KCPTUN_LOCALADDR` - the local address (for client) 
* `KCPTUN_REMOTEADDR` - the remote address (for client) 
* `KCPTUN_MODE` - the mode of operation, either fast2 or fast3 (both)
* `KCPTUN_CRYPT` - the encryption algorithm to use, either aes or tea (both)

The script will generate an appropriate command line for KCPTUN based on these environment variables and then execute it.

### Example

In this example, the KCPTUN-Client is a tunneling protocol that is used to establish a secure connection between the Client and the KCPTUN-Server. The KCPTUN-Server then forwards all traffic from the Client to the Server on port 10001. This allows for secure communication between the two endpoints without exposing any of their internal ports:

```
Client => KCPTUN-Client(10000) => KCPTUN-Server(50000) => Server(10001)
```

Type below content to `docker-compose.yml` file:

```yml
version: '3.8'

services:
  client:
    image: homqyy/kcptun-client:1.0-amd64
    environment:
      KCPTUN_LOCALADDR: ':10000'        # Listener of kcptun-client
      KCPTUN_REMOTEADDR: 'server:50000' # address of kcptun-server
      KCPTUN_MODE: fast3
      KCPTUN_CRYPT: salsa20

  server:
    image: homqyy/kcptun-server:1.0-amd64
    environment:
      KCPTUN_LISTEN: ':50000'           # listener of kcptun-server
      KCPTUN_TARGET: '127.0.0.1:10001'  # address of server
      KCPTUN_MODE: fast3
      KCPTUN_CRYPT: salsa20
```

## Dockerfile

This Dockerfile is used to build an image for [KCPTUN](https://github.com/xtaci/kcptun).

### Build Arguments
* `TARGETOS`: The target operating system, default to `linux`.
* `TARGETARCH`: The target architecture, default to `amd64`.
* `TYPE`: The type of KCPTUN, default to `server`.

### Environment Variables
* `KCPTUN_PROG`: Path of the KCPTUN binary. Default to `/bin/kcptun`. 
* `KCPTUN_TYPE`: Type of the KCPTUN binary. Default to the value of the build argument `TYPE`. 

### Labels 
This image uses labels for extra information about the image. 
* cn.homqyy.docker.project=kcptun 
* cn.homqyy.docker.type=release 
* cn.homqyy.docker.author=homqyy 
* cn.homqyy.docker.email=yilupiaoxuewhq@163.com 

### Usage 

To run a container from this image, use the following command:

```shell script
docker run --name kcptun -d homqyy/kcptun start <args>   # replace <args> with your own arguments for kcptun program  
```

## Example for Building Image

### Configure Build Environment

```bash
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --name mybuilder --driver docker-container --bootstrap
docker buildx use mybuilder
```

### Build Client Image:

```sh
docker buildx build --platform=linux/amd64,linux/arm/v7 -t homqyy/kcptun-client:1.0 --build-arg "TYPE=client" --push  .
```

### Build Server Image:

```sh
docker buildx build --platform=linux/amd64,linux/arm/v7 -t homqyy/kcptun-server:1.0 --build-arg "TYPE=server" --push  .
```

