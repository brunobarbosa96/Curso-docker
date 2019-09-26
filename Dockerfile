FROM node:carbon
LABEL maintainer="Luizalabs - Bruno Barbosa"

RUN useradd www
RUN mkdir /app
RUN mkdir /log
RUN chown www /log

USER www
VOLUME /log
WORKDIR /app
EXPOSE 3000

COPY *.js /app/

ENTRYPOINT ["node"]
CMD ["index.js"]