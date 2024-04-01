# Running JMeter script with Docker and K8s

### Build container with:
``` 
docker build -t my-jmeter-test . 
```
### Run the container with:
``` 
docker run -v /path/to/local/results:/results --name jmeter-test -it my-jmeter-test 
```
### To modify the jmeter script before run: 
``` 
nano /tests/loadScript.jmx 
```
### Run tests with:
``` 
jmeter -n -t /scripts/loadScript.jmx -l /results/test-results.jtl 
```
### Running with log file generation:
``` 
jmeter -n -t /scripts/loadScript.jmx -l /results/test-results.jtl > /results/jmeter.log 2>&1 
```

### To Copy the results on your machine:
``` 
docker cp jmeter-test:/results/test-results.jtl /path/to/local/results/
 ```
### Cleanup:
``` 
docker stop jmeter-test && docker rm jmeter-test 
```

## Tagging and pushing the Image to Docker Registry (required for k8s)
### DockerHub example:
``` 
docker login 
```
### Tag Your Docker Image
``` 
docker tag my-jmeter-test username/jmeter-image:latest
```
### Push the Image to DockerHub
``` 
docker push username/jmeter-image:latest
```

## Running in k8s:
### Before - be sure that jmeter docker image was pushed to docker registry
### Adjust the 'image' configuration in pod-definition.yaml accordingly
### Proceed to the k8s folder and execute:
``` 
kubectl apply -f pod-definition.yaml 
```

### Start bash session within the pod:
```
kubectl exec -it jmeter-pod -- /bin/bash
```
### Run tests from within the pod:
```
jmeter -n -t /scripts/loadScript.jmx -l /results/test-results.jtl
```
### Copy the results file 
```
kubectl cp jmeter-pod:/results/test-results.jtl ./test-results.jtl
```