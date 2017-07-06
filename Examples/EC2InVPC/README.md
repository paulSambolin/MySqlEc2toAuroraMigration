# Logstash on EC2
- EC2 Instance running the full ELK stack

## Current Configuration
- Current IP: 34.195.72.11
- Port numbers for Each service are as follows
  - Logstash      :6379
  - Elasticsearch :9200
  - Kibana        :5601

# Deploy Logstash service
- Follow instructions in gs.serverless.support/node4.3.2/README.md for instructions on how to deploy this serverless service from the command line
- The IP address of new EC2 Instances can be found in two locations in the console.
  - The resources tab of the Cloudformation stack
  - The instances page of the EC2 management console

# Configure Logstash service
- Once the service is successfully deployed, open 2 terminals in the directory containing PaulTest.pem (needed to ssh into and scp to the EC2 instance running logstash)

- Terminal #1 - SSH into the EC2 Instance:
  - `ssh -i PaulTest.pem ubuntu@34.195.72.11`

- Terminal #2 - scp files from local machine to the EC2 Instance
  - `scp -i Paultest.pem logstash.conf ubuntu@34.195.72.11:/home/ubuntu`

- Terminal #1 - Restart the Logstash service with new configuration
  - `/opt/logstash/bin/logstash -f /home/ubuntu/logstash.conf`

- Terminal #2 - To test new configuration:
  - `curl -XPUT 'http://34.195.72.11:6379/twitter/tweet/1' -d 'hello'`
  - `curl -XPUT 'http://34.195.72.11:6379/twitter/tweet/1' -d '{ "user" : "kimchy", "post_date" : "2009-11-15T14:12:12", "message" : "trying out Elasticsearch" }'`
  - `curl -XPUT 'http://34.195.72.11:6379/twitter/tweet/1' -d @testdata.json`

- To keep Logstash running after the Terminal has closed append a `&` to the command
  - `/opt/logstash/bin/logstash -f /home/ubuntu/logstash.conf &`

- To kill Logstash running in the background (or resolve any port errors)
  - Get the PID using `lsof -i:6379`
  - Kill the process with `kill <PID>` where `<PID>` is the Process Id received from the previous command