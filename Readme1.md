# Kubernetes Architecture, Namespaces, and Controllers

This README provides an overview of Kubernetes architecture, default namespaces, controllers, and communication patterns.

## Kubernetes Architecture

Kubernetes follows a master-worker architecture, consisting of the following main components:

### Master Node (Control Plane)

1. **API Server**
   - Front-end to the control plane
   - Exposes the Kubernetes API
   - Processes REST operations and updates the etcd datastore

2. **etcd**
   - Distributed key-value store
   - Stores all cluster data and state information
   - Provides consistent and highly-available storage for all cluster data

3. **Scheduler**
   - Watches for newly created pods with no assigned node
   - Selects a node for them to run on based on resource requirements, hardware/software/policy constraints, affinity and anti-affinity specifications, etc.

4. **Controller Manager**
   - Runs controller processes
   - Regulates the state of the cluster through the API server

5. **Cloud Controller Manager** (optional)
   - Interacts with the underlying cloud provider's API
   - Manages cloud-specific components like load balancers and storage volumes

### Worker Nodes

1. **Kubelet**
   - An agent that runs on each node in the cluster
   - Makes sure that containers are running in a Pod
   - Communicates with the master node's API Server

2. **Container Runtime**
   - Software responsible for running containers (e.g., Docker, containerd, CRI-O)

3. **Kube-proxy**
   - Network proxy that runs on each node
   - Maintains network rules on nodes
   - Performs connection forwarding

## Communication Patterns

### API Server Communication

- The API server is the central communication hub for all components
- Components don't communicate directly with each other, but through the API server

### Intra-cluster Communication

1. **Pod-to-Pod Communication**
   - Pods can communicate directly with each other using their IP addresses
   - Every Pod gets its own unique IP address within the cluster
   - Containers within a Pod share the same network namespace and can communicate via localhost

2. **Pod-to-Service Communication**
   - Services provide a stable IP address and DNS name for a set of Pods
   - Pods can communicate with Services using the Service's ClusterIP or DNS name

3. **Node-to-Node Communication**
   - Nodes communicate with each other directly over the network
   - This is used for functions like pod networking and distributed storage systems

4. **Control Plane to Node Communication**
   - The API server communicates with the kubelet on each node for pod management
   - The API server communicates with kube-proxy on each node for network configuration

### External Communication

1. **Ingress**
   - Manages external access to the services in a cluster, typically HTTP
   - Can provide load balancing, SSL termination, and name-based virtual hosting

2. **NodePort**
   - Exposes the service on each Node's IP at a static port

3. **LoadBalancer**
   - Exposes the service externally using a cloud provider's load balancer

4. **ExternalName**
   - Maps the service to the contents of the externalName field (e.g., foo.bar.example.com), by returning a CNAME record

## Default Namespaces

Kubernetes comes with four default namespaces:

1. **default**: The default namespace for objects with no other namespace
2. **kube-system**: The namespace for objects created by the Kubernetes system
3. **kube-public**: This namespace is created automatically and is readable by all users
4. **kube-node-lease**: This namespace for the lease objects associated with each node which improves the performance of the node heartbeats as the cluster scales

## Controllers

Kubernetes controllers are control loops that watch the state of your cluster, then make or request changes where needed. Each controller tries to move the current cluster state closer to the desired state. Here's a list of important controllers in Kubernetes:

1. **Replication Controller**
   - Ensures that a specified number of pod replicas are running at any given time
   - If there are too many pods, it will kill some; if there are too few, it will start more
   - Being replaced by ReplicaSets and Deployments

2. **ReplicaSet**
   - Next-generation Replication Controller
   - Supports set-based selector requirements
   - Usually used indirectly through Deployments

3. **Deployment**
   - Provides declarative updates for Pods and ReplicaSets
   - You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate
   - Manages rollout of new versions and rollback to previous versions

4. **StatefulSet**
   - Manages the deployment and scaling of a set of Pods, and provides guarantees about the ordering and uniqueness of these Pods
   - Maintains a sticky identity for each of their Pods
   - Useful for applications that require stable, unique network identifiers, stable persistent storage, and ordered deployment and scaling

5. **DaemonSet**
   - Ensures that all (or some) Nodes run a copy of a Pod
   - As nodes are added to the cluster, Pods are added to them
   - As nodes are removed from the cluster, those Pods are garbage collected
   - Useful for running cluster storage daemons, log collection daemons, and monitoring daemons on every node

6. **Job**
   - Supervisor process for Pods carrying out batch processes to completion
   - Creates one or more Pods and ensures that a specified number of them successfully terminate

7. **CronJob**
   - Manages time-based Jobs
   - Runs Jobs on a time-based schedule

8. **Horizontal Pod Autoscaler**
   - Automatically scales the number of pods in a replication controller, deployment, replica set or stateful set based on observed CPU utilization

9. **Node Controller**
   - Responsible for noticing and responding when nodes go down
   - Monitors the state of nodes and takes necessary actions to keep applications running

10. **Service Controller**
    - Responsible for watching the creation of new Service objects
    - Creates corresponding LoadBalancer for Services of type LoadBalancer

11. **Endpoints Controller**
    - Populates the Endpoints object (i.e., joins Services & Pods)
    - Watches for new Services and Pod changes to keep Endpoints up-to-date

12. **Namespace Controller**
    - Watches for namespaces being created or deleted and creates or deletes content for those namespaces

13. **Persistent Volume Controller**
    - Watches for PersistentVolumeClaims and tries to find a matching PersistentVolume to bind
    - If a PersistentVolume is not found, it will attempt to provision one if dynamic provisioning is enabled

14. **Garbage Collector**
    - Implements cascading deletion of resources
    - Helps maintain the cluster's hygiene by cleaning up unused resources

These components and controllers work together to manage the state of your Kubernetes cluster, ensuring that your applications run as desired and respond to changes in the environment.
