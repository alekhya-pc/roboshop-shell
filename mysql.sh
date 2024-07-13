source common.sh

PRINT Install MySql Service
dnf install mysql-server -y &>>$LOG_FILE
STAT $?

PRINT Start MySql Service
systemctl enable mysqld &>>$LOG_FILE
systemctl restart mysqld &>>$LOG_FILE
STAT $?

PRINT Setup Mysql root password
mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE
STAT $?