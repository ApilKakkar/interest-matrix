# Static site served by unprivileged nginx. Listens on $PORT (default 8080) — Cloud Run compatible.
FROM nginxinc/nginx-unprivileged:1.27-alpine
ENV PORT=8080
COPY docker/nginx.conf.template /etc/nginx/templates/default.conf.template
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -qO- http://127.0.0.1:${PORT}/healthz || exit 1
