FROM ubuntu:18.04
COPY package.json .

RUN apt-get update
RUN apt-get install lua5.1 luarocks -y
RUN luarocks install lcmark

COPY . .
EXPOSE 3000

#does nothing but keep the container running
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]