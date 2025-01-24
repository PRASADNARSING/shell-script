#!/bin/bash

USERID=$(id -u)
R="\e[31m"  # Red for errors
G="\e[32m"  # Green for success
Y="\e[33m"  # Yellow for warnings
N="\e[0m"   # Reset color

SOURCE_DIR="/home/ec2-user/app-logs"
LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

# Create logs folder if it doesn't exist
if [ ! -d "$LOGS_FOLDER" ]; then
    mkdir -p "$LOGS_FOLDER"
    echo "Directory $LOGS_FOLDER created."
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "ERROR:: You must have sudo access to execute this script"
        exit 1 #other than 0
    fi
}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME


FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "Files to be deleted: $FILES_TO_DELETE"

while read -r filepath # here filepath is the variable name, you can give any name
do
    echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
    rm -rf $filepath
    echo "Deleted file: $filepath"
done <<< $FILES_TO_DELETE

# Improved code of practice online suggestion
#!/bin/bash

# USERID=$(id -u)
# R="\e[31m"  # Red for errors
# G="\e[32m"  # Green for success
# Y="\e[33m"  # Yellow for warnings
# N="\e[0m"   # Reset color

# SOURCE_DIR="/home/ec2-user/app-logs"
# LOGS_FOLDER="/var/log/shellscript-logs"
# LOG_FILE=$(basename "$0" | cut -d "." -f1)
# TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
# LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

# # Create logs folder if it doesn't exist
# if [ ! -d "$LOGS_FOLDER" ]; then
#     mkdir -p "$LOGS_FOLDER"
#     echo "Directory $LOGS_FOLDER created." >> "$LOG_FILE_NAME"
# fi

# VALIDATE(){
#     if [ $1 -ne 0 ]; then
#         echo -e "$2 ... $R FAILURE $N" | tee -a "$LOG_FILE_NAME"
#         exit 1
#     else
#         echo -e "$2 ... $G SUCCESS $N" | tee -a "$LOG_FILE_NAME"
#     fi
# }

# CHECK_ROOT(){
#     if [ $USERID -ne 0 ]; then
#         echo "ERROR:: You must have sudo access to execute this script" | tee -a "$LOG_FILE_NAME"
#         exit 1 # Non-zero exit code
#     fi
# }

# echo "Script started executing at: $TIMESTAMP" | tee -a "$LOG_FILE_NAME"

# # Check if the script is being run as root
# CHECK_ROOT

# # Validate source directory
# if [ ! -d "$SOURCE_DIR" ]; then
#     echo -e "$R ERROR: Source directory $SOURCE_DIR does not exist. $N" | tee -a "$LOG_FILE_NAME"
#     exit 1
# fi

# # Find and delete files older than 14 days
# FILES_TO_DELETE=$(find "$SOURCE_DIR" -type f -name "*.log" -mtime +14)

# if [ -z "$FILES_TO_DELETE" ]; then
#     echo -e "No files older than 14 days found in $SOURCE_DIR ... $Y SKIPPING $N" | tee -a "$LOG_FILE_NAME"
# else
#     echo -e "Files to be deleted:\n$FILES_TO_DELETE" | tee -a "$LOG_FILE_NAME"

#     while IFS= read -r filepath; do
#         echo "Deleting file: $filepath" | tee -a "$LOG_FILE_NAME"
#         rm -rf "$filepath"
#         VALIDATE $? "Deleted file $filepath"
#     done <<< "$FILES_TO_DELETE"
# fi

# echo "Script execution completed at: $(date +%Y-%m-%d-%H-%M-%S)" | tee -a "$LOG_FILE_NAME"
