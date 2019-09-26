# Treinamento de docker

Passo a passo de instalação:

https://hub.docker.com

https://docs.docker.com/install/linux/docker-ce/ubuntu

Para adicionar distribuição do docker no mint:

```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
```


Após finalizar a instalação `reiniciar` a maquina para carregar os grupos


Rodar comando para testar se funcionou: 

```
docker run hello-world
```

## Comandos básicos 

Para baixar a imagem do centos:

```
ls /var
```

```
docker container run centos ls /var
```

* O comando acima irá instalar a imagem do centos e executar um comento dentro da imagem instalada e após a conclusão matará a instância do docker.

```
$ docker container ps

$ docker container ps -a

$ docker container run --rm centos ls /var

$ docker container ps -a
```

### Modo interativo

```
$ docker container run -it centos bash
   [root@fdfcaddfba45 /]#
   [root@fdfcaddfba45 /]# exit

$ docker container ps -a
```

### Nomeando container

```
$ docker container run --name labs-test -it centos bash
   [root@fdfcaddfba45 /]#
   [root@fdfcaddfba45 /]# exit

$ docker container ps -a

$ docker container run --name labs-test -it centos bash

$ docker: Error response from daemon: Conflict. The container name "/labs-test" is already in use by container "f9e52d0dec4a6c927e9c2b920f624196c9957a99246c635c3c45a0b956836348". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.

```

### Reutilizando container

```
$ docker container start labs-test -ai
   $ touch labs.txt
   $ exit

$ docker container start labs-test -ai
$ ls labs.txt
labs.txt

$ exit

```

### Verificar imagens instaladas

```
$ docker image list
```

### Rodando imagem do mysql

```
$ docker container run mysql -e MYSQL_ROOT_PASSWORD=root 
```

Para passar a porta específica rodar comando -p PORTA_INTERNA:PORTA_DOCKER como abaixo:

```
$ docker container run --name mysql-database -e MYSQL_ROOT_PASSWORD=root -p 33060:3306 mysql
```

### Comunicação com o container via Nginx

```
$ docker container run -p 8080:80 nginx
```

### Comunicação com o container via volume

* Criar uma pasta hospedeira na máquina local para que o docker passe a acessá-la
* `-v`: volume na máquina local em que o docker terá acesso dentro do container

```
$ mkdir ~/docker_volume
$ cd ~/docker_volume
$ touch 1.txt
$ touch 2.txt
$ docker container run -v ~/docker_volume:/teste -it centos bash
	$ cd teste
	$ ls
		2.txt  3.txt

```

### Container em background

* `-d`: Destacado (detashed)

```
$ docker container run -d --name nginx2 -p 8080:80 nginx
$ sudo docker container ps -a

CONTAINER ID  IMAGE   COMMAND                 CREATED              STATUS                           PORTS                  NAMES
59b1329a9769  nginx   "nginx -g 'daemon of…"  About a minute ago   Up About a minute                0.0.0.0:8080->80/tcp   nginx2
761652e8c151  centos  "bash"                  13 minutes ago       Exited (0) 13 minutes ago                               focused_beaver


$ sudo docker container stop nginx2
$ sudo docker container ps -a

$ sudo docker container start nginx2
$ sudo docker container ps -a

$ sudo docker container restart nginx2
$ sudo docker container ps -a

$ docker container logs nginx2

$ docker container exec nginx2 printenv
```

### Imagens

* Olhar imagens no site do docker-hub.

```
$ docker pull mysql:latest

$ docker image inspect

$ docker image tag mysql:latest labs-mysql

$ docker image ls

$ docker image rm

$ docker image build
```

### Criando uma imagem
* Criar um arquivo `Dockerfile` conforme exemplo presente neste repositório.
* No comando abaixo ele irá rodar o arquivo de imagem encontrado no caminho descrito por `.` que no casos representa a pasta local.

```
$ docker image build -t labs-build-1 .
```

Para executar a imagem criada: 

```
$ docker run -p 8080:80 labs-build-1
```