# sakila-cassandra

This is an adaptation of Sakila data set for MySQL that can be used 
to put some data into Cassandra.

## Warning

If you have a keyspace named `employees`, this script will drop it!

## Steps

1. Clone Sakila data set right into the working directory: `git clone https://github.com/datacharmer/test_db.git`
2. Run convertion script: `perl convert-data-file.pl`
3. Load data into Cassandra: `cqlsh -f employees.cql`

## Note

If you already have sakila data set elsewhere, you can use

`perl convert-data-file.pl --sakila-dir=/dir/with/sakila-data`
