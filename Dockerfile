FROM node:7-slim
RUN mkdir -p /usr/src/app
ADD . /usr/src/app/ 
RUN useradd meteor -G staff -m -s /bin/bash
RUN chown -R meteor:meteor /usr/src/app/
RUN apt-get update -y && apt-get install bzip2 curl -y
# install Meteor 
RUN curl "https://install.meteor.com/" | sh
ENV PORT 3000
EXPOSE 3000 
# build app ONBUILD 
ENTRYPOINT ["su", "-", "meteor"]
WORKDIR /usr/src/app/
CMD cd /usr/src/app/ && MONGO_URL='mongodb://user:password@cosmosmcas.documents.azure.com:10255/fichesdebanc?ssl=true' meteor --settings settings.json
