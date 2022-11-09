# !/bin/bash

BLACK='\033[0;30m'        # Black
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUE='\033[0;34m'         # Blue
PURPLE='\033[0;35m'       # Purple
CYAN='\033[0;36m'         # Cyan
WHITE='\033[0;37m'        # White
NC='\033[0m'

while [ -z ${OS} ]
do
	echo -e "${OS}Choose container Ubuntu version: 1 or 2, (1:18.04 , 2: 20.04):${NC}"
	read OS
	case ${OS} in
		1) OS=ubuntu:18.04
			;;
		2) OS=ubuntu:20.04
			;;
		*) OS=
			;;
	esac
done


echo -e "${YELLOW}Please input container's default username:${NC}"
echo -e "${YELLOW}Skip(enter)${NC}"
read NAME
if [ -z ${NAME} ]; then
	NAME=docker
fi

echo -e "${YELLOW}Please input conatiner's default password for root and ${NAME}:${NC}"
echo -e "${YELLOW}Skip(enter)${NC}"
read PASSWD
if [ -z ${PASSWD} ]; then
	PASSWD=docker
fi


echo -e "${YELLOW}Please input host worspace:${NC}"
echo -e "${YELLOW}Skip(enter)${NC}"
read WORKDIR
if [ -z ${WORKDIR} ]; then
	WORKDIR=/home/$USER
fi

echo -e "${YELLOW}Default username: ${NC}${NAME}"
echo -e "${YELLOW}Default password: ${NC}${NAME}"
echo -e "${YELLOW}Default mount directory: ${NC}${WORKDIR}"
sleep 3

RUN='./run.sh'
echo '# !/bin/bash' > ${RUN}
echo '' >> ${RUN}
echo 'docker run --privileged -it -v /dev/bus/usb:/dev/bus/usb -v /etc/udev:/etc/udev -v '${WORKDIR}':/home/'${NAME}/Workspace' nvidia:latest' >> ${RUN}
chmod +x ${RUN}

docker build --build-arg OS=${OS} --build-arg NAME=${NAME} --build-arg PASSWD=${PASSWD} -t nvidia -f nvidia.docker ./
