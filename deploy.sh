docker build -t phileveritt/multi-client:latest -t phileveritt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phileveritt/multi-server:latest -t phileveritt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phileveritt/multi-worker:latest -t phileveritt/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push phileveritt/multi-client:latest
docker push phileveritt/multi-server:latest
docker push phileveritt/multi-worker:latest
docker push peveritt/multi-client:$SHA
docker push peveritt/multi-server:$SHA
docker push peveritt/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/service-deployment server=peveritt/multi-server:$SHA
kubectl set image deployments/client-deployment client=peveritt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peveritt/multi-worker:$SHA
