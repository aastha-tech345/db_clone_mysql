
DB_USER="root"
DB_PASS="@devlogix2011"

SOURCE_DB="lisa_ehr_master"
TARGET_DB="lisa_ehr_clone"

DUMP_FILE="db_backup.sql"

echo "Cloning database from $SOURCE_DB to $TARGET_DB"

mysql -u $DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $TARGET_DB;"
echo "Database $TARGET_DB created (if not exists)."

mysqldump -u $DB_USER -p$DB_PASS $SOURCE_DB > $DUMP_FILE
echo "Dump of $SOURCE_DB completed."

mysql -u $DB_USER -p$DB_PASS $TARGET_DB < $DUMP_FILE
echo "Data imported into $TARGET_DB."

rm $DUMP_FILE
echo "Temporary dump file removed."

echo "Database clone completed successfully!"
