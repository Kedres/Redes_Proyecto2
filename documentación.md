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

- Mail Server:

- VPN: Este se instalo en la propia instancia virtual, por medio de los comandos "wget https://git.io/vpn -O openvpn-install.sh" y "sudo ./openvpn-install.sh", ya una vez instalado es necesario estar en la carpeta donde se ubique el archivo .pem con las claves SSH de la instancia y ejecutar el comando "sudo scp -i [archivo.pem] ubuntu@[direccion pública]:/home/ubuntu/myvpn.ovpn /home/william/Escritorio/" para crear el archivo que servirá para la conexión con la VPN del servidor. Finalmente se usa "sudo systemctl start openvpn-server@server.service" para activar el servicio, para que los cliente se conecten a este se puede hacer con el comando "sudo systemctl start openvpn@client" después de haber copiado el archivo de conexión.

- OpenSSL:

## Actividades Realizadas por Estudiante

### Kevin Segura:

### Manuel Ruiz:

## Autoevalución

### Kevin Segura:

### Manuel Ruiz:

## Lecciones Aprendidas

## Bibliografía
