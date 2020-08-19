## Introdución

En este proyecto consta de montar un servidor de servicios seguros por medio de la virtualización. Algunos de los servicios requerirán el ser cifrados, por lo que se debera instalar una entidad certificadora que firme sus propios certificados.  Además, también es necesario montar una centra telefónica PBX, que deberá poder realizar llamadas a través de CallMyWay, con al menos dos clientes (computadora de escritorio y teléfono), un cuarto de conferencias, horario establecido para las llamadas, manejo de extensiones y transferecias de llamadas. Finalmente, se deberá realizar una investigación sobre el proceso de instalación de OpenShift, y elementos relacionados a esta herramienta.

## Ambiente de Desarrollo

El trabajo se desarrollos en los siguiente ambientes:

- Ubuntu 18.04 LTS: SO operativo principal utilizado por uno de los integrantes.
- AWS Educate: Herramienta principal donde se montará el servidor virtual con los servicios.

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

## Instalación de Servicios

## Actividades Realizadas por Estudiante

## Autoevalución

## Lecciones Aprendidas

## Bibliografía
