source common.sh
component=rabbitmq

PRINT Copy rabbitmq repo file
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$LOG_FILE
STAT $?

PRINT Install rabbitmq
dnf install rabbitmq-server -y &>>$LOG_FILE
STAT $?

PRINT Start rabbitmq service
systemctl enable rabbitmq-server &>>$LOG_FILE
systemctl restart rabbitmq-server &>>$LOG_FILE
STAT $?

PRINT Created one user for application
rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
STAT $?