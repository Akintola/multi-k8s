docker build -t akintola/multi-client:latest -t akintola/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akintola/multi-server:latest -t akintola/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akintola/multi-worker:latest -t akintola/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akintola/multi-client
docker push akintola/multi-server
docker push akintola/multi-worker

docker push akintola/multi-client:$SHA
docker push akintola/multi-server:$SHA
docker push akintola/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/multi-client client=akintola/multi-client:$SHA
kubectl set image deployments/multi-server server=akintola/multi-server:$SHA
kubectl set image deployments/multi-worker worker=akintola/multi-worker:$SHA


