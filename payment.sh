source common.sh
component=payment
app_path=/app


PRINT install python
dnf install python3 gcc python3-devel -y
STAT $?

APP_PREREQ

PRINT install requirements
pip3 install -r requirements.txt
STAT $?

SYSTEMD_SETUP

