# GCP Notes

This repository contains notes and commands for working with Google Cloud Platform (GCP).

## Metadata and Basic Commands

- Retrieve instance zone: `curl metadata/computeMetadata/v1/instance/zone`
- List files: `ls`
- Create empty file: `touch`
- List all files (including hidden): `ls -al`

## Environment Setup

- Enable cookies in code editor
- Edit `.customize` file to install Terraform
- Check Terraform version: `terraform --version` (latest version 13)
- Initialize Terraform: `terraform init`
- Use interactive gcloud: `gcloud beta interactive`

## Cloud Shell

- Enable boost mode for better performance
- Cloud Shell quota: 50 hours
- Use web preview feature

## Quotas and Limits

- Rate quota: API requests per day
- Allocation quota
- Monitor and set alerts for quota (HTTP 429 errors)
- IAM quota editing: Request quota increase (approval within 2 business days)
- Queries per day limits

## IAM (Identity and Access Management)

- Principle of least privilege
- IAM components: Role, Member, Bindings
- Policy binds role to member
- Member types: Google account, service account, Google groups, G Suite domain, Google identity domain, All users
- Roles = Permissions (e.g., `compute.instances.list`)
- Role types: Primitive, Predefined (fine-grained access), Custom
- Conditions for access control (e.g., for contractors)
- Metadata: etags for concurrency control

### IAM Commands

- Get project IAM policy: `gcloud projects get-iam-policy`
- Get folder IAM policy: `gcloud resource-manager folders get-iam-policy`
- Get organization IAM policy: `gcloud organizations get-iam-policy`
- Add IAM policy binding: `gcloud projects add-iam-policy-binding`

## Service Accounts

- Types: Google-managed, User-managed
- Key types: Google-managed keys, User-managed keys (store in Google KMS)
- Access scopes (legacy method)
- Best practices:
  - Use minimum set of permissions
  - Implement API key rotation
- Attaching service accounts to VMs

### Service Account Commands

- List service accounts: `gcloud iam service-accounts list`
- Create service account: `gcloud iam service-accounts create`
- Stop VM instance: `gcloud compute instances stop instance-1 --zone us-central1-a`
- Set service account for instance: `gcloud compute instances set-service-account`

## Storage and Access

- Create and manage buckets
- SSH into Compute Engine instances
- Authenticate: `gcloud auth login`
- List config: `gcloud config list`
- List buckets: `gsutil ls gs://bucket-name`
- Copy files to bucket: `gsutil cp file gs://bucket-name`

## Additional Notes

- Cloud Identity for GCP IAM policies
- Organization policies
- Labels for resource management
- Audit logs generate large amounts of data
- Privacy and security considerations

Remember to follow best practices, use the principle of least privilege, and regularly review and update your IAM policies and service accounts.

cloud identity gives more control--identity as a service (IDaas)
device management 
two step verification
sso single sign on 
reporting for audit logs 
directory management --GCDS 
google cloud directory sync gcds--to sync ldap or active directory 
ad domain, ad federation services
iam best practices --principle of leaset privilege 
be cautious with owner roles
rotate user managed service account keys 
name service account keys to reflect user and permissions 
auditing --check all audit logs and changes --store in cloud storage for long term retention
organization level policy 

networking--\\







