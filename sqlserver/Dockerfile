# Dockerfile — baseado em Azure SQL Edge (imagem leve)
FROM mcr.microsoft.com/azure-sql-edge:latest

# Aceita termos (a senha será injetada em runtime, não no Dockerfile)
ENV ACCEPT_EULA=Y

USER root

# Instala ferramentas básicas e baixa o sqlcmd (go-sqlcmd) diretamente do GitHub
ARG SQLCMD_VER=v1.7.0
RUN apt-get update && apt-get install -y curl bzip2 ca-certificates \
    && curl -L -o /tmp/sqlcmd.tar.bz2 "https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VER}/sqlcmd-linux-amd64.tar.bz2" \
    && tar -xjf /tmp/sqlcmd.tar.bz2 -C /usr/local/bin \
    && chmod +x /usr/local/bin/sqlcmd \
    && rm -rf /var/lib/apt/lists/* /tmp/sqlcmd.tar.bz2

WORKDIR /usr/src/app

# Copia init.sql e o entrypoint
COPY ./init.sql /usr/src/app/init.sql
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

EXPOSE 1433

CMD ["/usr/src/app/entrypoint.sh"]
