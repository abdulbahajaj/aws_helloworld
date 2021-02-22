FROM ubuntu

RUN apt-get update && apt-get install -y jq unzip curl

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
	unzip awscliv2.zip && \
	./aws/install

WORKDIR /app/

ADD update_security_group.sh .

RUN chmod u+x update_security_group.sh

ENTRYPOINT ["bash", "update_security_group.sh"]
