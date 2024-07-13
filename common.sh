LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT() {
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo " ######################## $* ############################" &>>$LOG_FILE
  echo
  echo "Refer the log file for more information : File path : ${LOG_FILE}"
  echo $*
}

STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit $1
  fi
}

nodejs() {
  PRINT Disable nodejs Default Version
  dnf module disable nodejs -y &>>$LOG_FILE
  STAT $?

  PRINT Enable nodejs 20 Module
  dnf module enable nodejs:20 -y &>>$LOG_FILE
 STAT $?

  PRINT Install nodejs
  dnf install nodejs -y &>>$LOG_FILE
  STAT $?

  PRINT Copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  STAT $?

  PRINT Copy MongoDB repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
  STAT $?

  PRINT Adding Application user
  useradd roboshop &>>$LOG_FILE
  STAT $?

  PRINT clearing Old content
  rm -rf /app &>>$LOG_FILE
  STAT $?

  PRINT create App Directory
  mkdir /app &>>$LOG_FILE
  STAT $?

  PRINT Download App Content
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  STAT $?

  cd /app &>>$LOG_FILE

  PRINT extract App Content
  unzip /tmp/${component}.zip &>>$LOG_FILE
  STAT $?

  PRINT download nodejs Dependancies
  npm install &>>$LOG_FILE
  STAT $?

  PRINT Start Service
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
  STAT $?
}