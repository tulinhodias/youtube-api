FROM node:18

# Instalar python3 e pip3
RUN apt-get update && apt-get install -y python3 python3-pip

# Instalar yt-dlp via pip
RUN pip3 install yt-dlp

# Definir diretório da aplicação
WORKDIR /app

# Copiar arquivos package.json e index.js para dentro da imagem
COPY package.json ./
COPY index.js ./

# Instalar dependências node
RUN npm install

# Expor porta 3000
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "index.js"]

