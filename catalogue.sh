source common.sh
component=catalogue
nodejs
echo Install Mongodb Client
dnf install mongodb-mongosh -y &>>$LOG_FILE
if [$? -eq 0]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
echo Load Master Data
mongosh --host mongo.dev.alekhyab96.online </app/db/master-data.js &>>$LOG_FILE
if [$? -eq 0]; then
    echo SUCCESS
  else
    echo FAILURE
  fi