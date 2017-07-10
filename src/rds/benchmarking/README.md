How to setup:

sysbenchEC2.yml - will set up 4 ec2 instances and output their host addresses
aurora.yml - will set up an aurora rds instance and output


- a script - accepts the hostnames and type of test (read/write) as arguments, starts 4 parallel processes, ssh's into each machine, runs the read or write test, writes output to local files

