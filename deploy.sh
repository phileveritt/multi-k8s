docker build -t peveritt/multi-client:latest -t peveritt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peveritt/multi-server:latest -t peveritt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peveritt/multi-worker:latest -t peveritt/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push peveritt/multi-client:latest
docker push peveritt/multi-server:latest
docker push peveritt/multi-worker:latest
docker push peveritt/multi-client:$SHA
docker push peveritt/multi-server:$SHA
docker push peveritt/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/service-deployment server=peveritt/multi-server:$SHA
kubectl set image deployments/client-deployment client=peveritt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peveritt/multi-worker:$SHA
