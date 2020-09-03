FROM registry.fedoraproject.org/fedora-minimal
MAINTAINER dmoessne <dmoessne@redhat.com>

# RUN microdnf update && microdnf install nginx && microdnf clean all && rm -rf /var/cache/yum/ && rm -rf /usr/share/nginx/html/index.html
RUN microdnf install nginx && microdnf clean all && rm -rf /var/cache/yum/ && rm -rf /usr/share/nginx/html/index.html

EXPOSE 80

COPY ./startup.sh /
RUN chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]
