DB_USER="root"
DB_PASS="@devlogix2011"
SOURCE_DB="lisa_ehr_practice"
TARGET_DB="lisa_ehr_clinic"

# Define tables with data (comma-separated)
TABLE_WITH_DATA="database_configs diseases global_types mastercountry patient_medications_reasons recurring_settings roles snomedct_to_icd10 user_roles masterweekdays masterstate"

# Define stored procedures (optional – list if needed)
STORED_PROCS="GetICD10List GetICD10 Get_globalCategoryType_country_state"

# Temporary files
DUMP_STRUCTURE="structure_only.sql"
SP_DUMP_FILE="db_sp.sql"

# Step 1: Create the target DB
mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $TARGET_DB;"

# Step 2: Drop existing stored procedures
for proc in $STORED_PROCS; do
  mysql -u "$DB_USER" -p"$DB_PASS" -e "DROP PROCEDURE IF EXISTS $proc;" "$TARGET_DB"
done

# Step 3: Get all table names from source DB
ALL_TABLES=$(mysql -u "$DB_USER" -p"$DB_PASS" -Nse "SHOW TABLES FROM $SOURCE_DB")

# Step 4: Identify tables without data (structure-only)
STRUCTURE_ONLY_TABLES=""
for table in $ALL_TABLES; do
  if [[ ! ",$TABLE_WITH_DATA," =~ ",$table," ]]; then
    STRUCTURE_ONLY_TABLES+="$table "
  fi
done

# Step 5: Dump structure-only tables
mysqldump -u "$DB_USER" -p"$DB_PASS" --no-data "$SOURCE_DB" $STRUCTURE_ONLY_TABLES > "$DUMP_STRUCTURE"

# Step 6: Dump data+structure for tables with data
for table in $TABLE_WITH_DATA; do
  mysqldump -u "$DB_USER" -p"$DB_PASS" "$SOURCE_DB" "$table" > "${table}_data.sql"
done

# Step 7: Dump stored procedures
SP_WHERE=$(printf "'%s'," $STORED_PROCS | sed 's/,$//')  # 'proc1','proc2',...
mysqldump -u "$DB_USER" -p"$DB_PASS" "$SOURCE_DB" \
  --routines --no-create-info --no-data --no-create-db --skip-triggers \
  --where="ROUTINE_NAME IN ($SP_WHERE)" > "$SP_DUMP_FILE"

# Step 8: Import into target DB
mysql -u "$DB_USER" -p"$DB_PASS" "$TARGET_DB" < "$DUMP_STRUCTURE"

for table in $TABLE_WITH_DATA; do
  mysql -u "$DB_USER" -p"$DB_PASS" "$TARGET_DB" < "${table}_data.sql"
done

mysql -u "$DB_USER" -p"$DB_PASS" --force "$TARGET_DB" < "$SP_DUMP_FILE" 2>&1 | tee sp_import.log

# Step 9: Cleanup
rm "$DUMP_STRUCTURE"
rm "$SP_DUMP_FILE"
for table in $TABLE_WITH_DATA; do
  rm "${table}_data.sql"
done
