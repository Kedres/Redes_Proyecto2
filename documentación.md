## Introdución

En este proyecto consta de montar un servidor de servicios seguros por medio de la virtualización. Algunos de los servicios requerirán el ser cifrados, por lo que se debera instalar una entidad certificadora que firme sus propios certificados.  Además, también es necesario montar una centra telefónica PBX, que deberá poder realizar llamadas a través de CallMyWay, con al menos dos clientes (computadora de escritorio y teléfono), un cuarto de conferencias, horario establecido para las llamadas, manejo de extensiones y transferecias de llamadas. Finalmente, se deberá realizar una investigación sobre el proceso de instalación de OpenShift, y elementos relacionados a esta herramienta.

## Ambiente de Desarrollo

El trabajo se desarrollos en los siguiente ambientes:

- Ubuntu 18.04 LTS: SO operativo principal utilizado por uno de los integrantes.
- AWS Educate: Herramienta principal donde se montará el servidor virtual con los servicios.
- Agregue los suyos.

## Diseño

### Proyecto:

DataBase, WebServer y CMS: 

Iniciando con el WebServise, se estudio posibles soluciones, donde la elegida fue AWS Educate por sus facilidades y la ayuda que el TEC brinda para que uno pueda utilizar esta herramienta. Se utilizo el servicio integrado "EC2" para la creación de una instancia virtual que será el servidor donde montar los servicios, esta decisión se hizo tomando en cuenta las características de capacidad informatica en la nube segura y de tamaño modificable.

Para la base de datos se utilizo el servicio RDS, que cuenta con una gran facilidad para la creación, utilización y escalado de múltiples tipos de bases de datos. Hasta este punto eran servicios brindados por el mismo AWS, pero ya para la instalación de los servicios se decidio consultar la página https://hub.docker.com/ en busca de las mejores opciones, para el CMS se decidió utilizar Wordpress al ser de los más reconocidos y ya estar familiarizado con él.

VPN:

Para está labor se utilizo OpenVPN, específicamente una versión funcional en Ubuntu 18.04 extraida de git.io/vpn.

Acceso al CMS con nombre de dominio (DNS):

Gracias a EC2, que ya cuenta con un generador automático de dominios utilizables en la red, está labor se pudo hacer sin problemas desde la instancia virtual generada.

2 Sevicios con docker-compose:

Por temas de mayor entendimiento de la herramienta por el estudiante, a parte que fueron de los que mejor información se pudo encontrar, se decidio utilizar los servicios de owncloud y Email Server.

### Central telefónica:

## Instalación de Servicios

- Web Server: Antes que nada, se creo un security Group para el manejo del tráfico, para este ejercicio se permitió todo el tráfico para mayor facilidad. Ya con esto se procedio a específicar las características de la instacia, se escogió hacer una máquina virtual de procesamiento moderado con 15 gigas de almacenamiento, ya que se considero que no es mucho lo que se necesitará a la vez que se deja un margen para que tampoco falte. Finalmente, se crearon una llaves privada SSH para conectarse a la instancia a tráves de mi máquina local y agregar los servicios por la terminal.

- MySQL(RDS): Se busco el servicio dentro de AWS, dentro de él esta la opción "create", ahí pedirá la configuración deseada. Se escogio MySQL como se solicita en el proyecto, el Free Tier que era el que brindaba las condiciones más comodas para el servicio, se nombro como "cmsdatabase" con usuario maestro "admin" y password "123queso123", después de que levanto se procedio a ligarla a la instancia virtual EC2.

- Antes que nada se tuvo que instalar Docker y Docker-compose en la máquina virtual a la vez que se dieron los permisos correspondientes.

- Wordpress(CMS): Primer servicio docker, después de hacer el pull, inicialmente se corrió con el comando "sudo docker run -d -p 80:80 -e WORDPRESS_DB_HOST=endpoint:puerto(3306) -e WORDPRESS_DB_USER=<DB user> -e WORDPRESS_DB_PASSWORD=<DB password> wordpress", pero luego de investigación se logro ejecutar con docker-compose. Para acceder y usar este servicio se puede hacer a tráves de dominio http://ec2-34-232-78-241.compute-1.amazonaws.com/ por el puerto 80.
  
- OwnCloud: Se descago desde https://raw.githubusercontent.com/owncloud/docs/master/modules/admin_manual/examples/installation/docker/docker-compose.yml, se hizo la respectiva configuarción para que funcionara, y finalmente se puso en marcha con "sudo docker-compose up -d". Para acceder al servicio es por medio de la misma dirección pero por el puerto 8080.

- Mail Server: Se utilizo el servidor de correos poste.io, también encontrado en https://hub.docker.com/, se hizo el pull respectivo, y se creo el contenedor docker con el comando "docker run --net=host -e TZ=Europe/Prague -v /your-data-dir/data:/data --name "mailserver" -h "mail.example.com" -t analogic/poste.io", y finalmente se pone a ejecutar con el comando "sudo doker start id-contenedor". Para acceder es por el mismo dominio de la instancia, mediante el puerto 80 o el 443.

- VPN: Este se instalo en la propia instancia virtual, por medio de los comandos "wget https://git.io/vpn -O openvpn-install.sh" y "sudo ./openvpn-install.sh", ya una vez instalado es necesario estar en la carpeta donde se ubique el archivo .pem con las claves SSH de la instancia y ejecutar el comando "sudo scp -i [archivo.pem] ubuntu@[direccion pública]:/home/ubuntu/myvpn.ovpn /home/william/Escritorio/" para crear el archivo que servirá para la conexión con la VPN del servidor. Finalmente se usa "sudo systemctl start openvpn-server@server.service" para activar el servicio, para que los cliente se conecten a este se puede hacer con el comando "sudo systemctl start openvpn@client" después de haber copiado el archivo de conexión.

- OpenSSL: Se hizo pull al docker de este servicio, a continuación se creo el certificado del server con el comando "docker run -it -v $(pwd):/export frapsoft/openssl req -nodes -new -newkey rsa:2048 -sha256 -out /export/cert.pem", el cual da como resultado un archivo .pem con el certificado. Para hacer uso del servicio es directamente desde la instancia con el comando "docker run -it --entrypoint /bin/ash frapsoft/openssl".

- PBX: Haz lo tuyo manuel, aquí explico por encima como se artivo en servicio y como se utiliza.

## Actividades Realizadas por Estudiante

### Kevin Segura:

- Búsqueda de información para la investigacion de OpenShift. Horas invertidas: 2:30. Fecha: Lunes 3 de Agosto.
- Búsqueda de un poco más de información y escritura de parte de la investigación. Horas invertidas: 3. Fecha: Miercoles 5 de Agosto.
- Estudio de opciones para montar el Web Server. Horas invertidas: 1:30. Fecha: Lunes 10 de Agosto.
- Estudio básico de como usar AWS y posibles formas de montar los servicios. Horas invertidas: 2. Fecha: Martes 11 de Agosto.
- Creación de la instancia EC2, creación de la base de datos con RDS e investigación de dockers para los servicios descritos. Horas: 4:30. Fecha: Jueves 13 de Agosto.
- Instalación y comprobación del funcionamiento de los servicios Wordpress y OwnCloud. Horas invertidas: 3. Fecha: Viernes 14 de Agosto.
- Instalación de los servicios OpenSSL y OpenVPN, además de pruebas. Horas invertidas: 2:30. Fecha: Sabado 15 de Agosto.
- Instalación y pruebas del servicio Mail Server, además de investigar como utilizar docker-compose a partir de los contenedores creados. Horas invertidas: 4. Fecha: Lunes 17 de Agosto.
- Continuación de la creación de los archivos docker-compose. Problemas con la autentificación con OwnCLoud y con la creación del archivo docker-compose para el Mail Server, escritura de la documentación. Horas invertidas: 6. Fecha: Martes 18 de Agosto.
- Horast totales invertidas: 29 horas.

### Manuel Ruiz:

## Autoevalución

### Kevin Segura:

### Manuel Ruiz:

## Lecciones Aprendidas

## Bibliografía
