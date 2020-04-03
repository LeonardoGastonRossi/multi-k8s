docker build -t leonardorossi/multi-client:latest -t leonardorossi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t leonardorossi/multi-server:latest -t leonardorossi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t leonardorossi/multi-worker:latest -t leonardorossi/multi-worker:$SHA -f ./worker/Dockerfile ./worker


# Seteamos el latest para que cualquiera que se baje el repo en el futuro y corra el apply local, use la ultima version
docker push leonardorossi/multi-client:latest
docker push leonardorossi/multi-server:latest
docker push leonardorossi/multi-worker:latest

docker push leonardorossi/multi-client:$SHA
docker push leonardorossi/multi-server:$SHA
docker push leonardorossi/multi-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/client-deployment client=leonardorossi/multi-client:$SHA
kubectl set image deployments/server-deployment server=leonardorossi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=leonardorossi/multi-worker:$SHA
