source common.sh
component=dispatch
app_path=/app

PRINT install golang
dnf install golang -y &>>$LOG_FILE
STAT $?

APP_PREREQ

PRINT running mod function
go mod init dispatch &>>$LOG_FILE
STAT $?

PRINT running get function
go get &>>$LOG_FILE
STAT $?

PRINT running build function
go build &>>$LOG_FILE
STAT $?

SYSTEMD_SETUP

