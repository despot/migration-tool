# Run Using Kubernetes

We are going to deploy the [Docker containers](use-docker.md) to Kubernetes. We are going to use the Minikube - Docker Toolbox learning approach, because both are free. For more on other learning environments, check https://kubernetes.io/docs/setup/#learning-environment. Or for the production environment choices check the production environment section https://kubernetes.io/docs/setup/production-environment/container-runtimes/. 

Learning environments:
Community	                    Ecosystem  
Tried:  
Minikube	                    Docker Toolbox  
Not tried:    
Minikube	                    Docker Desktop  
kind (Kubernetes IN Docker)	    Minishift  
                                MicroK8s  (for linux users wishing to avoid running a virtual machine may consider MicroK8s as an alternative.)

If you haven't installed Minikube (check by running minikube start --driver=[<driver_name>](https://kubernetes.io/docs/setup/learning-environment/minikube/#specifying-the-vm-driver). Example: minikube start --driver=virtualbox), install it by following [this tutorial](https://kubernetes.io/docs/setup/learning-environment/minikube/).  
An example cmd output of running the the command:  
* minikube v1.9.2 on Microsoft Windows 10 Home 10.0.18363 Build 18363
* Using the virtualbox driver based on user configuration
* Downloading VM boot image ...
    > minikube-v1.9.0.iso.sha256: 65 B / 65 B [--------------] 100.00% ? p/s 0s
    > minikube-v1.9.0.iso: 174.93 MiB / 174.93 MiB [-] 100.00% 3.27 MiB p/s 53s
* Starting control plane node m01 in cluster minikube
* Downloading Kubernetes v1.18.0 preload ...
    > preloaded-images-k8s-v2-v1.18.0-docker-overlay2-amd64.tar.lz4: 542.91 MiB
* Creating virtualbox VM (CPUs=2, Memory=4000MB, Disk=20000MB) ...
* Found network options:
  - NO_PROXY=192.168.99.100
  - no_proxy=192.168.99.100
* Preparing Kubernetes v1.18.0 on Docker 19.03.8 ...
  - env NO_PROXY=192.168.99.100
  - env NO_PROXY=192.168.99.100
* Enabling addons: default-storageclass, storage-provisioner
* Done! kubectl is now configured to use "minikube"

  
## Preparing the docker image for local deployment: 
1. In order to make the image despotjakimovski/migration-tool available in the local minikube docker's repository, you need to:  
    ```sh
    docker build -t despotjakimovski/migration-tool:1.0 .
    ```
    You need the tag part ":1.0" for minikube docker to pull the image locally. For more check the section "Why do I need a tag for the image?".
    
2. Save the image as a tar archive and on each load, you set the environment variables so that it uses minikube Docker daemon:  
    ```sh
    docker save despotjakimovski/migration-tool:1.0 | (eval $(minikube docker-env) && docker load)
    ```

## Creating a Kubernetes Deployment for the Registration Service

1. Create a [kubernetes deployment](https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/#kubernetes-deployments):
    
    ```sh
    kubectl apply -f - <<EOF
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: reggo
    spec:
      selector:
        matchLabels:
          app: reggo-label
      template:
        metadata:
          labels:
            app: reggo-label
        spec:
         containers:
         - name: reggo
           image: "despotjakimovski/migration-tool:1.0"
           command: ["java"]
           args: ["-jar", "app.jar", "reg"]
           ports:
           - containerPort: 1111
    EOF
   
    OLD: kubectl create deployment reggo --image=despotjakimovski/migration-tool:1.0 -- java -jar app.jar reg
    OLDEST: kubectl create deployment migration-minikube --image=despotjakimovski/migration-tool:1.0
    ```
    The output of this should be: "deployment.apps/reggo created" OLDEST: "deployment.apps/migration-minikube created". 
    The ports section from spec->template->spec->containers->ports is optional.  
    
    At this point you have created a deployment ("reggo" - check metadata->name) and pod ("reggo-[randomString]" - check containers->-name and "kubectl get pods"):
    
    ```sh
    kubectl get pods
    ```
    To check whether the application has started properly, copy the pod name and get the logs:
    ```sh
    kubectl logs [podName]
    ```
    You should see "RegistrationServer - Started RegistrationServer" in the bottom of the log.
    
    ***Note***: It is not possible to have a deployment created with the kubectl create or kubectl run commands. For more, check "Why don't I run the pod by using "kubecetl create" or "kubectl run" commands?" in Q&A section below.  
    
2. To access the reggo Deployment, expose it as a Service. Run

   ```sh
   kubectl expose deployment reggo  --type=NodePort --port=1111
   OLD: kubectl expose deployment migration-minikube --type=NodePort --port=8080
   ```
   The outcome should be:
   ```sh
   service/reggo exposed
   OLD: service/migration-minikube exposed
   ```

## Checking the registration service online
   
3. To check the application in the browser do:
   ```sh
   kubectl describe pods
   ```
   and then you will see something like: 
   ```sh
   Node:         minikube/192.168.99.101
   ```
   Use the nodeIP from minikube/nodeIP (in this case 192.168.99.101) and the NodePort you got from "kubectl describe service reggo" (in this example: 30899):
   ```sh
    Name:                     reggo
    Namespace:                default
    Labels:                   <none>
    Annotations:              <none>
    Selector:                 app=reggo-label
    Type:                     NodePort
    IP:                       10.96.203.93
    Port:                     <unset>  1111/TCP
    TargetPort:               1111/TCP
    NodePort:                 <unset>  30899/TCP
    Endpoints:                172.17.0.2:1111
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
   ``` 
   and hit nodeIP:NodePort (in this case 192.168.99.101:30899). You will reach the Registration Server with this.  
   
   To understand why you need to use NodePort and the external Node IP and how the mechanism works between them, check the section "Do I need nodePort, port or targetPort to access the service externally?" below.

## Creating a Kubernetes Deployment for the COUNTRY-SERVICE

1. Creating the COUNTRY-SERVICE deployment (we change reggo to country, the arg "reg" to "country" as required in Main.java, and the containerPort to 2222):
    
    ```sh
    kubectl apply -f - <<EOF
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: country
    spec:
      selector:
        matchLabels:
          app: country-label
      template:
        metadata:
          labels:
            app: country-label
        spec:
         containers:
         - name: country
           image: "despotjakimovski/migration-tool:1.0"
           command: ["java"]
           args: ["-jar", "app.jar", "country"]
           ports:
           - containerPort: 2222
    EOF
    ```
    The output of this should be: "deployment.apps/country created". 
    The ports section from spec->template->spec->containers->ports is optional.  
    
    At this point you have created a deployment ("country" - check metadata->name) and pod ("country-[randomString]" - check containers->-name and "kubectl get pods"):
    
    ```sh
    kubectl get pods
    ```
    To check whether the application has started properly, copy the pod name and get the logs:
    ```sh
    kubectl logs [podName]
    ```
    You should see "System has 17 countries." in the middle of the log.  
    
2. To access the country Deployment, expose it as a Service. Run

   ```sh
   kubectl expose deployment country  --type=NodePort --port=2222
   ```
   The outcome should be:
   ```sh
   service/country exposed
   ```

## Checking the COUNTRY-SERVICE online
   
1. To check the application in the browser do:
   ```sh
   kubectl describe pods
   ```
   and then you will see something like: 
   ```sh
   Node:         minikube/192.168.99.101
   ```
   Use the nodeIP from minikube/nodeIP (in this case 192.168.99.101) and the NodePort you got from "kubectl describe service country" (in this example: 30899):
   ```sh
    Name:                     country
    Namespace:                default
    Labels:                   <none>
    Annotations:              <none>
    Selector:                 app=country-label
    Type:                     NodePort
    IP:                       10.96.203.93
    Port:                     <unset>  2222/TCP
    TargetPort:               2222/TCP
    NodePort:                 <unset>  32388/TCP
    Endpoints:                172.17.0.2:2222
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
   ``` 
   and hit nodeIP:NodePort (in this case 192.168.99.101:32388). You will reach the Country service with this.  

2. Return to the Eureka Dashboard in your browser and refresh the screen.  You should see that `COUNTRY-SERVICE` is now registered.

3. In a second browser tab, go to http://192.168.99.101:32388/countries/getAll. This is the web interface you just deployed and you should be able to view the countries information.

## Details, Questions & Answers

### Why don't I run the pod by using "kubecetl create" or "kubectl run" commands?

1. It is not possible to have a deployment created with the kubectl create command:  
     
    ```sh
    kubectl create deployment country --image=despotjakimovski/migration-tool:1.0
    ```
    while also having the command and arguments passed to the pod creation:
    ```sh
    -- java -jar app.jar reg
    ```
2. Also, you might have had the idea to use the kubectl run pod command:
    We first try to translate the docker run command that we already used to kubectl command. We had:
    ```sh
    docker run --name country --hostname country --network mt-net -p 1111:1111 despotjakimovski/migration-tool java -jar app.jar reg
    ```
    that translates to:
    ```sh
    kubectl run country --port 1111 --image=despotjakimovski/migration-tool:1.0 -- java -jar app.jar reg
    ```
    As the kubernetes cluster has it's own network, the docker --network parameter doesn't have any corresponding parameter in the kubectl command. The similar is for the docker --hostname parameter.  
     
    The kubectl run command would leave you with no deployment (hence no way for kubernetes to restart your pod automatically and other conveniences.) For more you can check [this stackoverflow question](https://stackoverflow.com/questions/61439079/how-to-have-the-pod-created-run-an-application-command-and-args-and-at-the-sam)
    A variation of this approach is [using a yaml file where the pod's command and args are set](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#define-a-command-and-arguments-when-you-create-a-pod), though it renders to the same result.
    
### Do I need nodePort, port or targetPort to access the service externally?

***In essence***, it is [not advisable to access the pod's(container's) IP and port directly since pods are rescheduled and a different IP or port might be assigned to the new pod within a node](https://kubernetes.io/docs/concepts/configuration/overview/#naked-pods-vs-replicasets-deployments-and-jobs). So you need to create a service that will generate a NodePort that will be externally accessible and that NodePort will forward to the pod's ip and port. The call chain is NodePort->Port->TargetPort.   

A good visual depiction of external request using the service's NodePort and that request being routed to the pod's port is seen in [this image](https://theithollow.com/wp-content/uploads/2019/01/image-20.png) from [the it hollow blog](https://theithollow.com/2019/02/05/kubernetes-service-publishing/). You can also see how pods are organized within nodes. If you want to read further the blog also explains how you can reach the other pods from a pod within the cluster by using pod's ip and port (they are available internally within the cluster).

Another good visual depiction of the same is seen in [this image](https://prod-edxapp.edx-cdn.org/assets/courseware/v1/21c20b2587efd20cd7af6cd6ed274eef/asset-v1:LinuxFoundationX+LFS158x+2T2017+type@asset+block/service-Nodeportupdated.png) from [the edxkubernetes blog](https://sites.google.com/site/edxkubernetes/services) where the request of frontend-svc (imagine it next to the user black arrow) is forwarded to the NodePort 32233, that in turn sends it to the Node frontend-svc that is translated to the Node IP: 172.17.0.4 and request pushed to the pods by getting their own IPs and ports. In the blog you can check the different type of Services (4) that you can create. A good [visual representation of the scope of 3 of the service types](https://i.stack.imgur.com/1owA5.jpg).  

For more details on the different port types and how they are used check [the serviceport documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.11/#serviceport-v1-core). Further explanation of how NodePort, port and targetPort work together you can find in [this stackoverflow](https://stackoverflow.com/questions/41963433/what-does-it-mean-for-a-service-to-be-of-type-nodeport-and-have-both-port-and-t/41963878#41963878).  

Some more information on [how services work](https://kubernetes.io/docs/concepts/services-networking/service/) and how to [setup services for applications](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/) you can find in the official kubernetes website. 

An overview diagram of the flow of how deployment service and other kubernetes entities play together you can find in [this image](https://image.slidesharecdn.com/openstackaustinmeetupsept21-170928195525/95/open-stackaustinmeetupsept21-21-638.jpg?cb=1506694184).

### What does \<unset> mean next to a port type for a service?

"\<unset>" means that the name of the appropriate port type is "unset". Check [this stackoverflow](https://stackoverflow.com/questions/42528409/kubernetes-what-does-unset-mean-in-port-in-a-service) for more.  

### Why do I need a tag for the image?

Mentioning a tag for the image is important as that way [the minikube docker would not search the non local repo by default](https://kubernetes.io/docs/concepts/containers/images/#updating-images).  
Otherwise, you would end up getting ImagePullBackOff on your pod:

   ```sh
   Normal   Pulling    17s (x3 over 62s)  kubelet, minikube  Pulling image "despotjakimovski/migration-tool"
   Warning  Failed     15s (x3 over 61s)  kubelet, minikube  Failed to pull image "despotjakimovski/migration-tool": rpc error: code = Unknown desc = Error response from daemon: pull access denied for despotjakimovski/migration-tool, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
   Warning  Failed     15s (x3 over 61s)  kubelet, minikube  Error: ErrImagePull
   Normal   BackOff    3s (x3 over 60s)   kubelet, minikube  Back-off pulling image "despotjakimovski/migration-tool"
   Warning  Failed     3s (x3 over 60s)   kubelet, minikube  Error: ImagePullBackOff
   ```

The other route is to [push it to the public docker hub repository](https://stackoverflow.com/questions/49298520/imagepullbackoff-error-google-kubernetes-engine), though you might need to [set credentials e.t.c.](https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod) (more work).

### Why do I get a CrashLoopBackOff?

If you get a CrashLoopBackOff and the pod restarted multiple times, you might think that there is a problem with memory or something that the environment needs. Though, when you create a deployment from the image by not specifying [command and argument parameters](https://stackoverflow.com/a/41710589/521754), you get a CrashLoopBackOff since the pod is terminated as not having any active (foreground) processes working. Kubectl commands that might render that are:
1. The [kubectl run command](https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/#docker-run):
    ```sh
    kubectl run reggo --port 1111 --image=despotjakimovski/migration-tool:1.0
    ```
    , as it starts a pod for the image despotjakimovski/migration-tool without any command and arguments.

2. The kubectl create deployment command:
    ```sh
    kubectl create deployment reggo --image=despotjakimovski/migration-tool:1.0
    ```
    , as it also starts a pod indirectly for the image despotjakimovski/migration-tool.
     
   The solutions here are:
3. either using the kubectl apply command with a file containing the command and arguments like we used in our example, or
4. using [ENTRYPOINT in Dockerfile](https://stackoverflow.com/questions/61439079/how-to-have-the-pod-created-run-an-application-command-and-args-and-at-the-sam), although we are omitting this step here as we want to use the same image for both the registration and country service (they have different arguments).  
5. add a [foreground process in linux](https://stackoverflow.com/a/50794554/521754).

You might need to [increase the time of the pod waits if the pod is not starting in the required time and hence giving you a CrashLoopBackOff](https://stackoverflow.com/a/53356654/521754).

A good place on why CrashLoopBackOff occurs has [this sysdig.com blog](https://sysdig.com/blog/debug-kubernetes-crashloopbackoff/).

### !!!!!!TBD!!!!!!!!!!!!!! Why am I getting Eureka Discovery Client issues?

You might get
    ```
    ERROR RedirectingEurekaHttpClient - Request execution error. endpoint=DefaultEndpoint{ serviceUrl='http://localhost:1111/eureka/}
    ...
    Connection refused (Connection refused)
    ```

This happens since your country service is trying to register itself to the eureka server being searched for at localhost:1111 since that is configured in the [registration-server.yml](registration-server.yml). 

To fix this you need to:
1. [set the hostname localhost for the node ip](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/).
2. expose the same 1111 port externally. 