FROM alpine:3.16.0

ENV VSFTPD_VERSION=3.0.5-r1

ARG FTP_USR
ARG FTP_PSW

RUN apk update && \
    apk add --no-cache vsftpd=${VSFTPD_VERSION}

RUN adduser -h /var/www -s /bin/false -D ${FTP_USR} && \
    echo "${FTP_USR}:${FTP_PWD}" | /usr/sbin/chpasswd && \
    adduser ${FTP_USR} root

# chroot_local_user=YES: Allows users to be jailed to their home directory.
# local_enable=YES: Enables local access for the user.
# write_enable=YES: Allows users to write to their home directory.
# local_umask=007: Sets the default file permissions for newly created files.
RUN sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_enable=YES|local_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#write_enable=YES|write_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_umask=022|local_umask=007|g"  /etc/vsftpd/vsftpd.conf

# allow_writeable_chroot=YES: Allows users to write within their chroot jail
# seccomp_sandbox=NO: Disables security sandbox for vsftpd
# pasv_enable=YES: Enables passive mode for FTP connections.
RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf &&\
    echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf && \
    echo 'pasv_enable=YES' >> /etc/vsftpd/vsftpd.conf

WORKDIR /var/www

EXPOSE 21

CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf" ]