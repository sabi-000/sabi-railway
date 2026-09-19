FROM node:20-bookworm-slim

WORKDIR /app
RUN apt-get update \
  && apt-get install -y --no-install-recommends openssl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install --omit=dev
COPY index.js ./

ENV NODE_ENV=production
ENV BK_DATA_DIR=/data/bk-data

CMD ["npm", "start"]
