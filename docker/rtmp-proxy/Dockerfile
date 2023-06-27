FROM alpine:3.18

ENV NGINX_VERSION nginx-1.24.0
ENV NGINX_RTMP_MODULE_VERSION 1.2.2

# download and decompress nginx rtmp module
RUN mkdir -p /tmp/src/nginx-rtmp-module && \
    cd /tmp/src/nginx-rtmp-module && \
    wget -O nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}.tar.gz https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_MODULE_VERSION}.tar.gz && \
    tar -zxf nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}.tar.gz

# download and decompress nginx source
RUN apk --update add openssl-dev pcre-dev zlib-dev wget build-base && \
    mkdir -p /tmp/src/nginx && \
    cd /tmp/src/nginx && \
    wget http://nginx.org/download/${NGINX_VERSION}.tar.gz && \
    tar -zxvf ${NGINX_VERSION}.tar.gz


# run nginx configure script to generate the makefile
RUN cd /tmp/src/nginx/${NGINX_VERSION} && \
    ./configure \
    --with-http_ssl_module \
    --with-stream \
    --with-http_gzip_static_module \
    --prefix=/etc/nginx \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --sbin-path=/usr/local/sbin/nginx \
    --add-module=/tmp/src/nginx-rtmp-module/nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}

# build nginx
RUN cd /tmp/src/nginx/${NGINX_VERSION} && \
    make && \
    make install && \
    apk del build-base && \
    rm -rf /tmp/src/nginx/ && \
    rm -rf /var/cache/apk/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx/nginx.conf etc/nginx/conf/nginx.conf

VOLUME ["/var/log/nginx"]

WORKDIR /etc/nginx

EXPOSE 80 443 1935

CMD ["nginx", "-g", "daemon off;"]