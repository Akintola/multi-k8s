docker build -t akintola/multi-client:latest -t akintola/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akintola/multi-server:latest -t akintola/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akintola/multi-worker:latest -t akintola/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akintola/multi-client:latest
docker push akintola/multi-server:latest
docker push akintola/multi-worker:latest

docker push akintola/multi-client:$SHA
docker push akintola/multi-server:$SHA
docker push akintola/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=akintola/multi-client:$SHA
kubectl set image deployment/server-deployment server=akintola/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=akintola/multi-worker:$SHA


