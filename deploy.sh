docker build -t danielpremkumar/multi-client:latest -t danielpremkumar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danielpremkumar/multi-server:latest -t danielpremkumar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danielpremkumar/multi-worker:latest -t danielpremkumar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push danielpremkumar/multi-client:latest
docker push danielpremkumar/multi-server:latest
docker push danielpremkumar/multi-worker:latest

docker push danielpremkumar/multi-client:$SHA
docker push danielpremkumar/multi-server:$SHA
docker push danielpremkumar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danielpremkumar/multi-server:$SHA
kubectl set image deployments/client-deployment client=danielpremkumar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=danielpremkumar/multi-worker:$SHA
