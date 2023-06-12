#!/bin/bash

# Set your AWS access key ID and secret access key
#export AWS_ACCESS_KEY_ID="your-access-key-id"
#export AWS_SECRET_ACCESS_KEY="your-secret-access-key"

# Set the S3 bucket name and prefix for the objects
S3_BUCKET="pgp-decrypted-files-12392023"
OBJECT_PREFIX="inbox/"
OBJECT_PREFIX_AFTER="outbox/"

# Set the local directory where decrypted files will be saved
LOCAL_DIR="/home/ubuntu/songyot-gpg-01/save/decrypted-files/"

# Download the encrypted files from S3
aws s3 cp "s3://${S3_BUCKET}/${OBJECT_PREFIX}" /tmp --recursive --exclude "*" --include "*.gpg"

# Decrypt each file using gpg
for file in /tmp/*.gpg; do
  filename=$(basename "$file")
  output_file="${LOCAL_DIR}${filename%.gpg}"
  gpg --decrypt --output "$output_file" "$file"

# Upload the decrypted file to S3
  aws s3 cp "$output_file" "s3://${S3_BUCKET}/${OBJECT_PREFIX_AFTER}${filename%.gpg}"
done

# Remove the temporary encrypted files
rm /tmp/*.gpg

# Display a success message
echo "Decryption complete. Files saved in ${LOCAL_DIR}"

