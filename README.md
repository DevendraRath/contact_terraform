## Prerequisites
* install and configure AWS cli
* install Terraform

## Build And Deploy

### create s3 bucket
Terraform fetches the code from s3. 
Change the name of the S3 bucket `contact-bucket2022` to something of your liking.
Be sure to change it in the `upload-to-s3.sh` file and in the `general.tf` file under variable `variable "s3_bucket"          { default = "contact-bucket2022"}`

Create an s3 bucket via the cli with the next command.
```
aws s3api create-bucket --bucket contact-bucket2022 --region us-east-2 --create-bucket-configuration LocationConstraint=us-east-2
```

### Upload code to S3

- upload the code of the lambda functions to an S3 Bucket: 
```
./upload-to-s3.sh
```

### Deploy using terraform

```
cd terraform
terraform apply
```

### Postman Collection
Terraform Contact.postman_collection