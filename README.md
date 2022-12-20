# Kursach
  1. Переходим в репозиторий, где лежит проект: cd "C:\Users\Yelena.Repnaya\Desktop\Kursach\"
  2. docker build -t repnaiae/kursach:1.0.0 . - сборка Docker image с тегом 1.0.0
Результат: [+] Building 0.3s (9/9) FINISHED
 => [internal] load build definition from Dockerfile                                                               0.1s
 => => transferring dockerfile: 32B                                                                                0.0s
 => [internal] load .dockerignore                                                                                  0.1s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3-alpine                                                 0.0s
 => [1/4] FROM docker.io/library/python:3-alpine                                                                   0.0s
 => [internal] load build context                                                                                  0.1s
 => => transferring context: 59B                                                                                   0.0s
 => CACHED [2/4] WORKDIR /app                                                                                      0.0s
 => CACHED [3/4] ADD app/hello.html /app                                                                           0.0s
 => CACHED [4/4] RUN adduser -Du 1001 web                                                                          0.0s
 => exporting to image                                                                                             0.1s
 => => exporting layers                                                                                            0.0s
 => => writing image sha256:1f954aec87cb26e9f3806c0569a455a5ef5a892ee8c06eed71f7ede1bffad86c                       0.0s
 => => naming to docker.io/repnaiae/kursach:1.0.0                                                                  0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
  3. docker run --rm -p 8000:8000 repnaiae/kursach:1.0.0 - проверка выполнения и создания страницы html на http://localhost:8080/
Результат: 172.17.0.1 - - [20/Dec/2022 08:50:29] "GET / HTTP/1.1" 200 -
172.17.0.1 - - [20/Dec/2022 08:50:33] "GET /hello.html HTTP/1.1" 200 -
  4. docker push repnaiae/kursach:1.0.0 - пуш image на DockerHub
  5. kubectl apply -f web.yaml - Устанавливаем manifest в кластер Kubernetes
Результат: deployment.apps/web-deployment created
  6. kubectl get pods -l app=web - проверяем правильность работы
Результат: NAME                              READY   STATUS    RESTARTS   AGE
           web-deployment-855ddf8f4b-24fx2   1/1     Running   0          3m2s
           web-deployment-855ddf8f4b-w4lgs   1/1     Running   0          3m2s
Создано два пода, READY 1/1, STATUS Running - значит всё хорошо
  7. kubectl port-forward --address 0.0.0.0 deployment/web 8080:8000 - обеспечить доступ к web-приложению web
Результат: Forwarding from 0.0.0.0:8080 -> 8000
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
По адресу http://127.0.0.1:8080/hello.html можно видеть сообщение Hello world!
