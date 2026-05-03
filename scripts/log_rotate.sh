#!/bin/bash

set -eu

display_usage(){
                echo "provide path of drectory want to rotate"
                echo "./log_rotate.sh /var/log/myapp"
                exit 1
}

if [ $# -eq 0 ]; then
    display_usage
fi
dir=$1

if [ -d "$1" ]
then
        echo "directory exists"
else 
        echo "file doesn't exists"
fi

gzip_num=0
remove_count=0


compressed(){
                error_logs=$(find $dir -name "*.log*" -mtime +7)
                for file in $error_logs;do
                if [[ $file != *.gz ]]; then
                        gzip $file
                        gzip_num=$((gzip_num + 1))
                fi
                done
}


remove_dir(){
                zip_logs=$(find $dir -name "*.gz" -mtime +30)
                for file in $zip_logs;do
                        rm $file
                        remove_count=$((remove_count + 1))
                done
}



compressed
remove_dir

echo "zipped : $gzip_num"
echo "removed : $remove_count"
