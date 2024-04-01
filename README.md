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

## Running in k8s:
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