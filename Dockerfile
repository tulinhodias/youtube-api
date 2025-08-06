FROM node:18

# Atualizar repositórios e instalar python3, pip e venv
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Criar e ativar virtualenv, depois instalar yt-dlp dentro dela
RUN python3 -m venv /opt/venv
RUN /opt/venv/bin/pip install --upgrade pip
RUN /opt/venv/bin/pip install yt-dlp

# Definir diretório da aplicação
WORKDIR /app

# Copiar arquivos do projeto
COPY package.json ./
COPY index.js ./

# Instalar dependências Node.js
RUN npm install

# Expor porta 3000
EXPOSE 3000

# Definir variáveis de ambiente para usar o virtualenv
ENV PATH="/opt/venv/bin:$PATH"

# Iniciar aplicação
CMD ["node", "index.js"]

