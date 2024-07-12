source common.sh
component=catalogue
nodejs
dnf install mongodb-mongosh -y &>$LOG_FILE
mongosh --host mongo.dev.alekhyab96.online </app/db/master-data.js &>$LOG_FILE