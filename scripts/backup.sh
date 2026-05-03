#!/bin/bash
set -eu

usage(){
    echo "Usage : backup.sh source/path destination/path"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

SOURCE="$1"    
DEST="$2"

check_source(){
    [ -d "$SOURCE" ] || { echo "Source invalid"; exit 1; }
    mkdir -p "$DEST"
    echo "Both OK"
}

backup(){
    echo "BACKUP IN PROGRESS..."
    ARCHIVE_file="$DEST/backup-$(date +%Y-%m-%d-%H-%M-%S).tar.gz"  
    if tar -czf "$ARCHIVE_file" "$SOURCE"; then  
        echo "BACKUP COMPLETED"
    else
        echo "BACKUP FAILED" >&2
        exit 1
    fi
}

print_file(){
    size=$(du -h "$ARCHIVE_file" | cut -f1) 
    echo "Archive: $ARCHIVE_file"
    echo "Size: $size"
}

delete(){
    count=$(find "$DEST" -name 'backup-*.tar.gz' -mtime +14 | wc -l)
    find "$DEST" -name 'backup-*.tar.gz' -mtime +14 -delete
    [ "$count" -gt 0 ] && echo "REMOVED $count OLD BACKUPS"
}

check_source && backup && print_file && delete
echo "DONE!"
