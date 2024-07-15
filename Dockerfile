FROM ubuntu:20.04

# Installer les paquets nécessaires
RUN apt-get update && apt-get install -y \
    vsftpd \
    s3fs \
    awscli \
    fuse \
    && rm -rf /var/lib/apt/lists/*

# Ajouter l'utilisateur FTP
RUN useradd -m ftpuser && echo "ftpuser:password" | chpasswd

# Configurer vsftpd
COPY vsftpd.conf /etc/vsftpd.conf

# Script de démarrage
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exposer les ports FTP et passifs
EXPOSE 2121
EXPOSE 30000-30100

CMD ["/start.sh"]
