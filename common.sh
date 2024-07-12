LOG_FILE=/tmp/roboshop.log
nodejs() {
  echo Disable nodejs Default Version
  dnf module disable nodejs -y &>>$LOG_FILE

  echo Enable nodejs 20 Module
  dnf module enable nodejs:20 -y &>>$LOG_FILE

  echo Install nodejs
  dnf install nodejs -y &>>$LOG_FILE

  echo Copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE

  echo Copy MongoDB repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE

  echo Adding Application user
  useradd roboshop &>>$LOG_FILE

  echo clearing Old content
  rm -rf /app &>>$LOG_FILE

  echo create App Directory
  mkdir /app &>>$LOG_FILE

  echo Download App Content
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE

  cd /app &>>$LOG_FILE

  echo extract App Content
  unzip /tmp/${component}.zip &>>$LOG_FILE

  echo download nodejs Dependancies
  npm install &>>$LOG_FILE

  echo Start Service
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
}