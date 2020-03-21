docker build -t porzechowski/multi-client:latest -t porzechowski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t porzechowski/multi-server:latest -t porzechowski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t porzechowski/multi-worker:latest -t porzechowski/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push porzechowski/multi-client:latest
docker push porzechowski/multi-server:latest
docker push porzechowski/multi-worker:latest

docker push porzechowski/multi-client:$SHA
docker push porzechowski/multi-server:$SHA
docker push porzechowski/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=porzechowski/multi-client:$SHA
kubectl set image deployments/server-deployment server=porzechowski/multi-server:$SHA
kubectl set image deployments/worker-deployment server=porzechowski/multi-worker:$SHA

