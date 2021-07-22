docker file 개발환경, 운영환경을 위한 파일을 따로 만드는게 편하다
Dockerfile.dev
Dockerfile 


Dockerfile.dev 만으로 이미지 docker build ./ 빌드실행시 'unable to evaluate symlink...'에러가보인다
dockerfile이 없고 dockerfile.dev만 있기 떄문이다.
이렇게 하면된다.
-f: 어떠한 dockerfile을 참조할지 명시할떄 쓰는 테그
docker build -f Dockerfile.dev ./

docker환경에서 개발할떄는 local에 있는 nodemodule 지워줘도된다.
이미 컨테이너안에서 npm install해서 node_module이 이미 존재하고
그이후에 실행되는 COPY ./ ./ 에서 node_modules 복사하려고 한다 근데 이것은 쓸데없는짓이다.

-i: 상호입출력
-t: tty를 활성화하여 bash쉘을 사용
react 는 3000포트에서 실행되기떄문에 -p태그로 포트지정도 해줘야한다.
docker run -p 3000:3000 brian/docker-react

***** react hot loading 을 사용하기위해서는 *****
추가적으로 -e CHOKIDAR_USEPOLLING=true를 넣어주거나
env 설정으로 넣어주던가 해야한다 (mac은 자체적으로 usePolling이 true이고 리눅스는 네트워크를통한 바인드가 아니어서 polling을 안해도 정상적인 watch가 가능하다)
https://www.inflearn.com/questions/65535 참조

docker run -it -p 3000:3000 -v /usr/src/app/node_modules -v ${pwd}:/usr/src/app -e CHOKIDAR_USEPOLLING=true brian/docker-react


Docker 를 이용한 리액트 앱에서 테스트를 진행하려면
이미지생성 docker build -f dockerfile.dev ./
앱 실행 docker run -it(더좋은 포맷으로 결과값을 보기위한옵션) 이미지이름 npm run test

docker-compose up --build
                   Build images before starting containers.
