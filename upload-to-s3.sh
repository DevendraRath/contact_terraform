#!/usr/bin/env bash

# Zip the lambda functions
rm -r getLambda.zip postLambda.zip
cd get
zip -r ../getLambda.zip index.js
cd ../post
zip -r ../postLambda.zip index.js
cd ..

# Upload code to s3
aws s3 cp getLambda.zip s3://codingtips-node-bucket/v1.0.0/getLambda.zip
aws s3 cp postLambda.zip s3://codingtips-node-bucket/v1.0.0/postLambda.zip