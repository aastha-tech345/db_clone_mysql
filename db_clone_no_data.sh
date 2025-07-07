
DB_USER="root"
DB_PASS="@devlogix2011"

SOURCE_DB="lisa_ehr_master"
TARGET_DB="lisa_ehr_clone_no_data"

DUMP_FILE="structure_only_backup.sql"

echo "Cloning structure from $SOURCE_DB to $TARGET_DB"

mysql -u $DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $TARGET_DB;"
echo "Database $TARGET_DB created (if not exists)."

mysqldump -u $DB_USER -p$DB_PASS --no-data $SOURCE_DB > $DUMP_FILE
echo "Structure dump of $SOURCE_DB completed."

mysql -u $DB_USER -p$DB_PASS $TARGET_DB < $DUMP_FILE
echo "Structure imported into $TARGET_DB."

rm $DUMP_FILE
echo "Temporary dump file removed."

echo "Structure-only clone completed successfully!"
