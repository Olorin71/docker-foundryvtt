FROM ubuntu:latest

# Set the foundry install home
RUN adduser --disabled-login --gecos "" foundry && mkdir -p /home/foundry/fvtt && mkdir -p /home/foundry/fvttdata

ENV FOUNDRY_HOME=/home/foundry/fvtt
ENV FOUNDRY_DATA=/home/foundry/fvttdata

RUN apt update && apt upgrade -y && apt install curl unzip -y && curl -sL https://deb.nodesource.com/setup_22.x | bash - && apt install nodejs -y
RUN npm install pm2 -g --omit=optional

# Set the current working directory
WORKDIR "${FOUNDRY_HOME}"
#copy found
COPY ./foundryvtt/* .

#unzip
RUN unzip FoundryVTT*.zip  && rm FoundryVTT*.zip
RUN ls -la && ls -la ..

EXPOSE 30000
CMD ["pm2-runtime", "${FOUNDRY_HOME}/resources/app/main.js --dataPath=${FOUNDRY_DATA}"]
# CMD node ${FOUNDRY_HOME}/resources/app/main.js --dataPath=${FOUNDRY_DATA}
