# GDG-SILIGURI-X-GCCD-Extended-Event: Deploying a Python Web App Using Docker on Google Cloud Run

Welcome to our tutorial where you'll learn how to deploy a simple Python web application using Docker and Google Cloud Run. We'll utilize Terraform for infrastructure orchestration.

## Prerequisites
Ensure you have the following installed:
1. [Git](https://git-scm.com/downloads) (version 2.39 or higher)
2. [Docker](https://www.docker.com/get-started/) (version 27.0 or higher)
3. [gcloud CLI](https://cloud.google.com/sdk/gcloud)
4. [Terraform](https://www.terraform.io/downloads.html) (version 1.6 or higher)

For manual provisioning via the console, please see the references section at the end of this document.

## Tutorial Steps

### Step 1: Clone the Repository
Clone the repository to get the required files:
```bash
git clone git@github.com:Google-Developer-Groups-Siliguri/GDG-SILIGURI-X-GCCD-Extended-Event.git
```

### Step 2: Setup Google Cloud Console
Create a Google Cloud account and login to the console. Once logged in, create a new project.

### Step 3: Update Project ID
Update the project ID in the `Makefile` and `terraform/terraform.tfvars` files. Replace the placeholder with your own project ID.

### Step 4: Build and Push the Docker Image
Build and push the Docker image to your Google Container Registry:
```bash
make docker-push
```
You will be redirected to your browser to authenticate. Complete the authentication process, and this will build and push your Docker image to GCR.

### Step 5: Deploy Your Application
Navigate to the `terraform` directory and run the following command:
```bash
terraform apply
```
You will be prompted with the planned changes. Type `yes` and press Enter to continue. After some time, you will receive a successful response along with the public URL of your application as output.

In this step, we are creating a Cloud Run service that will run this application in a container, granting public access to your service.

### Step 6: Verify Functionality
Visit the provided URL to see your application in action. You can also test its functionality using `curl`:
```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"num1": 10, "num2": 50}' \
  https://[YOUR_CLOUD_RUN_URL]/add

{"result":60}
```

## References
For those interested in manual provisioning via the Google Cloud Console, please refer to [Google Cloud Documentation](https://cloud.google.com/docs).
- [Create a google cloud project](https://developers.google.com/workspace/guides/create-project)
- [Create a cloud run service](https://cloud.google.com/run/docs/deploying)
