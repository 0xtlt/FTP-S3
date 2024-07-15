#!/bin/bash

# Vérifier que les variables d'environnement nécessaires sont définies
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ] || [ -z "$S3_BUCKET_NAME" ] || [ -z "$S3_REGION" ] || [ -z "$S3_ENDPOINT" ]; then
  echo "Les variables d'environnement AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, S3_BUCKET_NAME, S3_REGION et S3_ENDPOINT doivent être définies."
  exit 1
fi

# Monter le bucket S3 DigitalOcean
s3fs $S3_BUCKET_NAME /home/ftpuser/s3mnt -o allow_other -o use_path_request_style -o endpoint=$S3_REGION -o url=https://$S3_ENDPOINT

# Démarrer vsftpd
/usr/sbin/vsftpd /etc/vsftpd.conf
