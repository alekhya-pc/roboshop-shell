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
  echo $?

  PRINT Enable nodejs 20 Module
  dnf module enable nodejs:20 -y &>>$LOG_FILE
  echo $?

  PRINT Install nodejs
  dnf install nodejs -y &>>$LOG_FILE
  echo $?

  PRINT Copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  echo $?

  PRINT Copy MongoDB repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
  echo $?

  PRINT Adding Application user
  useradd roboshop &>>$LOG_FILE
  echo $?

  PRINT clearing Old content
  rm -rf /app &>>$LOG_FILE
  echo $?

  PRINT create App Directory
  mkdir /app &>>$LOG_FILE
  echo $?

  PRINT Download App Content
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  echo $?

  cd /app &>>$LOG_FILE

  PRINT extract App Content
  unzip /tmp/${component}.zip &>>$LOG_FILE
  echo $?

  PRINT download nodejs Dependancies
  npm install &>>$LOG_FILE
  echo $?

  PRINT Start Service
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
  echo $?
}