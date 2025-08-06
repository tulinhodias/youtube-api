FROM node:18

# Instalar python3 e pip3
RUN apt-get update && apt-get instFROM node:18

# Instalar python3, pip3 e virtualenv
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Criar virtualenv para o yt-dlp
RUN python3 -m venv /opt/yt-dlp-venv

# Ativar virtualenv e instalar yt-dlp
RUN /bin/bash -c "source /opt/yt-dlp-venv/bin/activate && pip install yt-dlp"

# Definir diretório da aplicação
WORKDIR /app

# Copiar arquivos package.json e index.js para dentro da imagem
COPY package.json ./
COPY index.js ./

# Instalar dependências node
RUN npm install

# Adicionar yt-dlp no PATH
ENV PATH="/opt/yt-dlp-venv/bin:$PATH"

# Expor porta 3000
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "index.js"]

