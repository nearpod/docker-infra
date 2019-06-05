
FROM nginx:1.17.0-alpine

COPY nginx.template /etc/nginx/

ENV NGINX_PORT=8080
ENV NGINX_SERVER_NAME=jira.example.com
ENV NGINX_SERVER_DEST=https://example.atlassian.net/projects/PROJ

EXPOSE ${NGINX_PORT}

# Run Atlassian JIRA as a foreground process by default.
CMD ["/bin/sh", "-c", "envsubst '$NGINX_PORT$NGINX_SERVER_NAME$NGINX_SERVER_DEST' < /etc/nginx/nginx.template > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'"]
