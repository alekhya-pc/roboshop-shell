source common.sh
component=frontend
app_path=/usr/share/nginx/html

PRINT disable nginx Default version
dnf module disable nginx -y &>>$LOG_FILE
STAT $?

PRINT enable nginx 24 version
dnf module enable nginx:1.24 -y &>>$LOG_FILE
STAT $?

PRINT install nginx
dnf install nginx -y &>>$LOG_FILE
STAT $?

PRINT copy nginx conf file
cp nginx.conf /etc/nginx/nginx.conf &>>$LOG_FILE
STAT $?

APP_PREREQ

PRINT Start nginx service
systemctl enable nginx &>>$LOG_FILE
systemctl restart nginx &>>$LOG_FILE
STAT $?