# Imagem oficial do SQL Server
FROM mcr.microsoft.com/mssql/server:2022-latest

# Aceitar termos de licença e senha do SA
ENV ACCEPT_EULA=Y

# Atualiza pacotes e instala o sqlcmd
USER root
RUN apt-get update && \
    apt-get install -y curl apt-transport-https gnupg2 && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools unixodbc-dev && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /usr/src/app

# Copia o script de inicialização
COPY ./init.sql /usr/src/app/init.sql

EXPOSE 1433

# Inicia o SQL, espera, executa o init.sql usando a variável de ambiente $SA_PASSWORD (fornecida em runtime)
CMD /bin/bash -c "/opt/mssql/bin/sqlservr & sleep 180 && /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P \"$SA_PASSWORD\" -i /usr/src/app/init.sql && tail -f /dev/null"