docker build -t williamdrew/multi-server:latest -t williamdrew/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t williamdrew/multi-client:latest -t williamdrew/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t williamdrew/multi-worker:latest -t williamdrew/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push williamdrew/multi-server:latest
docker push williamdrew/multi-client:latest
docker push williamdrew/multi-worker:latest

docker push williamdrew/multi-server:$SHA
docker push williamdrew/multi-client:$SHA
docker push williamdrew/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=williamdrew/multi-server:$SHA
kubectl set image deployments/client-deployment client=williamdrew/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=williamdrew/multi-worker:$SHA

