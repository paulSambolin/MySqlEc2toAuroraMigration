How to benchmark:
1. aurora.yml - deploy to spin up a vpc, subnets, and an aurora database cluster
2. sysbenchEc2.yml - deploy an ec2 instance, install sysbench.  Amazon's benchmarking used 4 of these instances running in parallel to benchamark the performance of aurora
3. start an ssh session with each sysbench instance
`ssh -i <path-to-private-key> ec2-user@<ec2-instance-ip-address>`
4. on only one of the instances - run /tmp/setup.sh
```bash
cd /tmp
sudo ./setup.sh
```
5. on all of the sysbench instances in parallel - run /tmp/readTest.sh or /tmp/writeTest.sh
```bash
cd /tmp
sudo ./readTest.sh
```
Link to AWS's offical whitepapar on benchmarking aurora: https://d0.awsstatic.com/product-marketing/Aurora/RDS_Aurora_Performance_Assessment_Benchmarking_v1-2.pdf
