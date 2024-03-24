FROM node:21-alpine
# Esta instrução define a imagem base como node:21-alpine, que é a imagem oficial do Node.js na versão 21 baseada no Alpine Linux.

WORKDIR /usr/src/app
# Define o diretório de trabalho dentro do contêiner como /usr/src/app, onde a aplicação será executada.

COPY package*.json ./
# Copia o arquivo package.json e qualquer arquivo package-lock.json (ou que comece com "package" e termine com ".json")
# do diretório de construção do Docker para o diretório de trabalho dentro do contêiner.

RUN npm install
# Executa o comando npm install para instalar as dependências listadas no package.json

COPY . .
# Copia todo o conteúdo do diretório de construção do Docker (contexto de construção) para o
# diretório de trabalho dentro do contêiner. Isso inclui o código-fonte da aplicação Node.js e quaisquer outros arquivos necessários.

EXPOSE 3000
# Informa ao Docker que o contêiner escutará conexões na porta 3000. No entanto, isso não
# publica automaticamente a porta para o host; você precisará fazer isso manualmente.

CMD [ "npm", "start" ]
# Define o comando padrão a ser executado quando o contêiner for iniciado. Neste caso, ele inicia a aplicação Node.js usando o comando npm start.