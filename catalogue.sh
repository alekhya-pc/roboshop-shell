source common.sh
component=catalogue
app_path=/app
nodejs
echo Install Mongodb Client
dnf install mongodb-mongosh -y &>>$LOG_FILE
STAT $?
echo Load Master Data
mongosh --host mongo.dev.alekhyab96.online </app/db/master-data.js &>>$LOG_FILE
STAT $?