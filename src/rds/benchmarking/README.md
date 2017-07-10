How to setup:
- TODO: write a script - accepts the hostnames and type of test (read/write) as arguments, starts 4 parallel processes, ssh's into each machine, runs the read or write test, writes output to local files

1. aurora.yml - deploy to spin up a vpc, subnets, and an aurora database cluster
2. sysbenchEc2.yml - deploy an ec2 instance, install sysbench.  Amazon's benchmarking used 4 of these instances running in parallel to benchamark the performance of aurora
3. start an ssh session with each sysbench instance
4. on only one of the instances - run the /tmp/setup.sh
5. on all of the sysbench instances in parallel - run the /tmp/readTest.sh or /tmp/writeTest.sh
