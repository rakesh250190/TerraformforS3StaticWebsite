This repository holds terraform script for provisioning s3 bucket, enabling bucket policy, uploading index and error html file, enabling web hosting on s3.
Below resources will be created by script:
1. S3 bucket #update your bucket name in variable.tf file. Ensure that bucket name is unique globally.
2. Bucket policy
3. bucket object - index.html and error.html #Update content as per your requirement
4. Public access on bucket, Bucket policy to allow getobject permission. #You may update as per your need.

Pre-requisites:
1. Install AWS SDK and configue access keys.Ensure access key has permission to provision above resources.
2. Install terraform
3. Update variable.tf file as per your environment