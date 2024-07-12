source common.sh
component=catalogue
nodejs
echo Install Mongodb Client
dnf install mongodb-mongosh -y &>$LOG_FILE
echo Load Master Data
mongosh --host mongo.dev.alekhyab96.online </app/db/master-data.js &>$LOG_FILE