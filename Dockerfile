FROM node:20-bookworm-slim

WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY index.js ./

ENV NODE_ENV=production
ENV BK_DATA_DIR=/data/bk-data

VOLUME ["/data"]
EXPOSE 3000

CMD ["npm", "start"]
