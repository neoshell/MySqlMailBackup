# Your configs

mysql_user=your_user
mysql_pass=your_pass
mysql_database=your_database
temp_dir=/your/temp/dir/
mail_address=your_mail@gmail.com

# Backup MySQL database, compress, send via email

date_string=$(date +%Y%m%d)

sql_file=$mysql_database'_'$date_string'.sql'
mysqldump -u$mysql_user -p$mysql_pass --databases $mysql_database > $temp_dir$sql_file

tar_gz_file=$sql_file'.tar.gz'
tar zcfP $temp_dir$tar_gz_file $temp_dir$sql_file

mail_subject='Database Backup: '$mysql_database
mail_content=$tar_gz_file
echo $mail_content | mutt -s "$mail_subject" -a $temp_dir$tar_gz_file -- $mail_address

rm $temp_dir$tar_gz_file
rm $temp_dir$sql_file
