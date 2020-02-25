docker build -t jigneshkvp/multi-client:latest -t jigneshkvp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jigneshkvp/multi-server:latest -t jigneshkvp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jigneshkvp/multi-worker:latest -t jigneshkvp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jigneshkvp/multi-client:latest
docker push jigneshkvp/multi-server:latest
docker push jigneshkvp/multi-worker:latest

docker push jigneshkvp/multi-client:$SHA
docker push jigneshkvp/multi-server:$SHA
docker push jigneshkvp/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jigneshkvp/multi-client:$SHA
kubectl set image deployments/server-deployment server=jigneshkvp/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jigneshkvp/multi-worker:$SHA