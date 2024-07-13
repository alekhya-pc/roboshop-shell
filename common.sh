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
  if [$? -eq 0]; then
    echo SUCCESS
  else
    echo FAILURE
  fi

  PRINT Enable nodejs 20 Module
  dnf module enable nodejs:20 -y &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT Install nodejs
  dnf install nodejs -y &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT Copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT Copy MongoDB repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT Adding Application user
  useradd roboshop &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT clearing Old content
  rm -rf /app &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT create App Directory
  mkdir /app &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT Download App Content
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  cd /app &>>$LOG_FILE

  PRINT extract App Content
  unzip /tmp/${component}.zip &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT download nodejs Dependancies
  npm install &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

  PRINT Start Service
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
  if [$? -eq 0]; then
      echo SUCCESS
    else
      echo FAILURE
    fi
}