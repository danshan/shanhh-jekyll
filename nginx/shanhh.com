
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name shanhh.com www.shanhh.com;

    # Redirect all HTTP requests to HTTPS with a 301 Moved Permanently response.
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name shanhh.com www.shanhh.com;

    # certs sent to the client in SERVER HELLO are concatenated in ssl_certificate
    ssl_certificate /etc/letsencrypt/live/shanhh.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/shanhh.com/privkey.pem;
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:50m;

    # Diffie-Hellman parameter for DHE ciphersuites, recommended 2048 bits
    ssl_dhparam /etc/ssl/certs/dhparam.pem;

    # intermediate configuration. tweak to your needs.
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS';
    ssl_prefer_server_ciphers on;

    # HSTS (ngx_http_headers_module is required) (15768000 seconds = 6 months)
    add_header Strict-Transport-Security max-age=15768000;

    # OCSP Stapling ---
    # fetch OCSP records from URL in ssl_certificate and cache them
    ssl_stapling on;
    ssl_stapling_verify on;

    server_name shanhh.com www.shanhh.com;
    root /jekyll/blog/_site;

    location / {
        index index.html index.htm;
    }

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|css|js|html|htm)$ {
        expires      1h;
    }

#    location ^~ /blog/files/ {
#        return 301 http://cdn.shanhh.com$request_uri;
#    }

#    location ^~ /blog/assets/ {
#        return 301 https://cdn.shanhh.com$request_uri;
#    }

}

server {
    listen 80;
    server_name calendar.shanhh.com;
    return 301 https://calendar.google.com/calendar;
}

server {
    listen 80;
    server_name contact.shanhh.com contacts.shanhh.com;
    return 301 https://contacts.google.com/preview/all;
}

server {
    listen 80;
    server_name mail.shanhh.com;
    return 301 https://mail.google.com;
}