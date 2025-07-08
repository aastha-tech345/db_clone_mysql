# DB_USER="root"
# DB_PASS="@devlogix2011"
# SOURCE_DB="lisa_ehr_practice"
# TARGET_DB="lisa_ehr_clinic"
# DUMP_FILE="db_selected_tables.sql"
# SP_DUMP_FILE="db_sp.sql"
# TABLES="users user_roles user_devices snomedct_to_icd10 roles role_and_permissions role_and_modules recurring_settings icd10 global_types global_category_types formtemplates database_configs"

# mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $TARGET_DB;"

# mysqldump -u "$DB_USER" -p"$DB_PASS" "$SOURCE_DB" $TABLES > "$DUMP_FILE"

# mysqldump -u "$DB_USER" -p"$DB_PASS" "$SOURCE_DB" --routines --no-create-info --no-data --no-create-db --skip-triggers | grep -E "PROCEDURE \`(GetICD10List|GetICD10|Get_globalCategoryType_country_state)\`" -A 100 > "$SP_DUMP_FILE"

# mysql -u "$DB_USER" -p"$DB_PASS" "$TARGET_DB" < "$DUMP_FILE"

# mysql -u "$DB_USER" -p"$DB_PASS" --force "$TARGET_DB" < "$SP_DUMP_FILE" 2>&1 | tee sp_import.log

# rm "$DUMP_FILE"
# rm "$SP_DUMP_FILE"


#!/bin/bash

# DB_USER="root"
# DB_PASS="@devlogix2011"
# SOURCE_DB="lisa_ehr_practice"
# TARGET_DB="lisa_ehr_clinic"
# DUMP_FILE="db_selected_tables.sql"
# SP_DUMP_FILE="db_sp.sql"
# TABLES="users user_roles user_devices snomedct_to_icd10 roles role_and_permissions role_and_modules recurring_settings icd10 global_types global_category_types formtemplates database_configs"

# # Create the target database if it doesn't exist
# mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $TARGET_DB;"

# # Drop existing stored procedures in the target database to avoid leftovers
# mysql -u "$DB_USER" -p"$DB_PASS" -e "DROP PROCEDURE IF EXISTS GetICD10List, GetICD10, Get_globalCategoryType_country_state, GetLabByPatientAndLabId, Get_stateByCountryId, SearchPatientsWithStaff;" "$TARGET_DB"

# # Dump the specified tables
# mysqldump -u "$DB_USER" -p"$DB_PASS" "$SOURCE_DB" $TABLES > "$DUMP_FILE"

# # Dump only the specified stored procedures using a precise filter
# mysqldump -u "$DB_USER" -p"$DB_PASS" "$SOURCE_DB" --routines --no-create-info --no-data --no-create-db --skip-triggers --where="ROUTINE_NAME IN ('GetICD10List', 'GetICD10', 'Get_globalCategoryType_country_state')" > "$SP_DUMP_FILE"

# # Import tables
# mysql -u "$DB_USER" -p"$DB_PASS" "$TARGET_DB" < "$DUMP_FILE"

# # Import stored procedures with force to handle potential errors
# mysql -u "$DB_USER" -p"$DB_PASS" --force "$TARGET_DB" < "$SP_DUMP_FILE" 2>&1 | tee sp_import.log

# # Clean up
# rm "$DUMP_FILE"
# rm "$SP_DUMP_FILE"






# #!/bin/bash

# DB_USER="root"
# DB_PASS="@devlogix2011"
# SOURCE_DB="lisa_ehr_practice"
# TARGET_DB="lisa_ehr_clinic"
# DUMP_FILE="db_selected_tables.sql"
# SP_DUMP_FILE="db_sp.sql"
# TABLES="users user_roles user_devices snomedct_to_icd10 roles role_and_permissions role_and_modules recurring_settings icd10 global_types global_category_types formtemplates database_configs"

# # Create the target database if it doesn't exist
# mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $TARGET_DB;"

# # Drop existing stored procedures individually in the target database
# mysql -u "$DB_USER" -p"$DB_PASS" -e "DROP PROCEDURE IF EXISTS GetICD10List;" "$TARGET_DB"
# mysql -u "$DB_USER" -p"$DB_PASS" -e "DROP PROCEDURE IF EXISTS GetICD10;" "$TARGET_DB"
# mysql -u "$DB_USER" -p"$DB_PASS" -e "DROP PROCEDURE IF EXISTS Get_globalCategoryType_country_state;" "$TARGET_DB"

# # Dump the specified tables
# mysqldump -u "$DB_USER" -p"$DB_PASS" "$SOURCE_DB" $TABLES > "$DUMP_FILE"

# # Dump only the specified stored procedures
# mysqldump -u "$DB_USER" -p"$DB_PASS" "$SOURCE_DB" --routines --no-create-info --no-data --no-create-db --skip-triggers --where="ROUTINE_NAME IN ('GetICD10List', 'GetICD10', 'Get_globalCategoryType_country_state')" > "$SP_DUMP_FILE"

# # Import tables
# mysql -u "$DB_USER" -p"$DB_PASS" "$TARGET_DB" < "$DUMP_FILE"

# # Import stored procedures with force to handle potential errors
# mysql -u "$DB_USER" -p"$DB_PASS" --force "$TARGET_DB" < "$SP_DUMP_FILE" 2>&1 | tee sp_import.log

# # Clean up
# rm "$DUMP_FILE"
# rm "$SP_DUMP_FILE"