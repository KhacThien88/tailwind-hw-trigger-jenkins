ARG VERSION=latest

FROM node:${VERSION} 

RUN apt-get update && apt-get install -y xsel

WORKDIR /HW-W03

COPY . .

RUN npm install -D tailwindcss postcss autoprefixer

RUN npx tailwindcss init

RUN npx tailwindcss -i ./input.css -o ./output.css --watch

RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", ".", "--no-clipboard"]