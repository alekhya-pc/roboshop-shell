source common.sh
component=payment
app_path=/app


PRINT install python
dnf install python3 gcc python3-devel -y &>>$LOG_FILE
STAT $?

APP_PREREQ

PRINT install requirements
pip3 install -r requirements.txt &>>$LOG_FILE
STAT $?

SYSTEMD_SETUP

