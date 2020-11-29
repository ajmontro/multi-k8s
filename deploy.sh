docker build -t ajmdocking/multi-client:latest -t ajmdocking/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t ajmdocking/multi-server:latest -t ajmdocking/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajmdocking/multi-worker:latest -t ajmdocking/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ajmdocking/multi-client:latest
docker push ajmdocking/multi-server:latest
docker push ajmdocking/multi-worker:latest

docker push ajmdocking/multi-client:$SHA
docker push ajmdocking/multi-server:$SHA
docker push ajmdocking/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajmdocking/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajmdocking/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajmdocking/multi-worker:$SHA