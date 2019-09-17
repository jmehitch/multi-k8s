docker build -t jmehitch/multi-client:latest -t jmehitch/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jmehitch/multi-server:latest -t jmehitch/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jmehitch/multi-worker:latest -t jmehitch/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jmehitch/multi-client:latest
docker push jmehitch/multi-server:latest
docker push jmehitch/multi-worker:latest

docker push jmehitch/multi-client:$SHA
docker push jmehitch/multi-server:$SHA
docker push jmehitch/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jmehitch/multi-server:$SHA
kubectl set image deployments/client-deployment client=jmehitch/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jmehitch/multi-worker:$SHA