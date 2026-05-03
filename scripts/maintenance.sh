#!/bin/bash

log_rotation(){

        /home/ubuntu/log_rotate.sh /var/log/myapp >> /var/log/maintenance.log
}

backup(){
         /home/ubuntu/backup.sh /home/ubuntu/testing /home/ubuntu/destination >> /var/log/maintenance.log
}

main(){
        echo -e "\n$(date) : IN MAINTENANCE.... " >> /var/log/maintenance.log
        log_rotation
        backup
        echo "MAINTENANCE COMPLETED..." >> /var/log/maintenance.log
}

main
echo "Successfully written logs to /var/log/maintenance.log"
