FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

#ngnix서버를 이용해 prod환경 배포시 서버로 사용한다. ngnix이미지를 빌드도 필요하다
#위에 앱이미지 빌드는 html파일로 빌드해서 결과를 build폴더안에 넣는다
#그다음 ngnix이미지를 빌드하면 ngix서버가 그빌드된 파일들을 사용해서 브라우저에 띄운다
FROM nginx
# as bulder 라고 적힌 스테이지에서 나온 결과물을 COPY 한다 
COPY --from=builder /usr/src/app/build /usr/share/ngnix/html
