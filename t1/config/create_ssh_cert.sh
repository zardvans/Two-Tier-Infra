openssl req -new -newkey rsa:2048 -nodes -keyout local.ictech.key -out local.ictech.csr -subj "/CN=local.ictech.com.sg/O=Local ICTech/C=SG"

openssl x509 -req -days 365 -in local.ictech.csr -signkey local.ictech.key -out local.ictech.crt -extfile <(printf "subjectAltName=DNS:local.ictech.com.sg,DNS:localhost")