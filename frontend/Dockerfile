FROM node:23.5-bookworm-slim

WORKDIR /app
COPY . .

RUN npm install

ENV HOST=0.0.0.0
ENV PORT=3000

EXPOSE 3000
CMD ["npm", "start", "--", "-h", "0.0.0.0"]
