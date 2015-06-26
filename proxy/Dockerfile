FROM nginx

RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    vim \
    curl \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Configure Nginx and apply fix for very long server names
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
# && sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf

RUN mkdir /code
WORKDIR /code
ADD . /code

CMD ["./run.sh"]
