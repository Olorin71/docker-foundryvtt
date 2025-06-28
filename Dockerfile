FROM ubuntu:latest

# Set the foundry install home
RUN mkdir -p /opt/foundry/fvtt && mkdir -p /opt/foundry/fvttdata

ENV FOUNDRY_HOME=/opt/foundry/fvtt
ENV FOUNDRY_DATA=/opt/foundry/fvttdata

RUN apt update && apt upgrade -y && apt install curl unzip -y && curl -sL https://deb.nodesource.com/setup_22.x | bash - && apt install nodejs -y
RUN npm install pm2 -g --omit=optional

# Set the current working directory
WORKDIR "${FOUNDRY_HOME}"
#copy found
COPY ./foundryvtt/* .

#unzip
RUN unzip FoundryVTT*.zip  && rm FoundryVTT*.zip
RUN chmod -R 766 ${FOUNDRY_HOME}
RUN chmod -R 766 ${FOUNDRY_DATA}

EXPOSE 30000
CMD ["pm2-runtime", "${FOUNDRY_HOME}/main.js --dataPath=${FOUNDRY_DATA}"]
# CMD node ${FOUNDRY_HOME}/resources/app/main.js --dataPath=${FOUNDRY_DATA}
