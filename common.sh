LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT() {
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo" ######################## $* ############################" &>>$LOG_FILE
  echo $*
}
nodejs() {
  PRINT Disable nodejs Default Version
  dnf module disable nodejs -y &>>$LOG_FILE

  PRINT Enable nodejs 20 Module
  dnf module enable nodejs:20 -y &>>$LOG_FILE

  PRINT Install nodejs
  dnf install nodejs -y &>>$LOG_FILE

  PRINT Copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE

  PRINT Copy MongoDB repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE

  PRINT Adding Application user
  useradd roboshop &>>$LOG_FILE

  PRINT clearing Old content
  rm -rf /app &>>$LOG_FILE

  PRINT create App Directory
  mkdir /app &>>$LOG_FILE

  PRINT Download App Content
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE

  cd /app &>>$LOG_FILE

  PRINT extract App Content
  unzip /tmp/${component}.zip &>>$LOG_FILE

  PRINT download nodejs Dependancies
  npm install &>>$LOG_FILE

  PRINT Start Service
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
}