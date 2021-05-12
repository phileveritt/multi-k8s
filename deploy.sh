docker build -t phileveritt/multi-client:latest -t phileveritt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phileveritt/multi-server:latest -t phileveritt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phileveritt/multi-worker:latest -t phileveritt/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push phileveritt/multi-client:latest
docker push phileveritt/multi-server:latest
docker push phileveritt/multi-worker:latest
docker push phileveritt/multi-client:$SHA
docker push phileveritt/multi-server:$SHA
docker push phileveritt/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/service-deployment server=phileveritt/multi-server:$SHA
kubectl set image deployments/client-deployment client=phileveritt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phileveritt/multi-worker:$SHA
