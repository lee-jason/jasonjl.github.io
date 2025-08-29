# Notes
- SQLite is for a single service. Is not connectable over http
- ECS is an orchestration service
- ALB is the gateway for external clients to communicate with the internal private VPC

Subnets
- VPC like a house, Subnets room in a house
-- All subnets can talk to each other

DB
- Has a problem of most likely requiring a single write node
- Can shard the data by domain (vertical) or horizontal (key range) to create completely independent managed versions of db. Sharded data will not have expectation to talk to other shards
- 10k - 50k writes per second is when we should think about splitting out sharding.
- 

EC2 Instances connect to outside
- 

Network Connectivity
- Internet Gateway (IGW) - Connects VPC to outside internet. All requests in and out go through the gateway.

- NAT Gateway - Allows outbound internet access, translates private IP to public IP. Must be in public subnet
- Route Table - Directions for where a request should be sent. Defined per subnet. Private subnet needs a route table pointing internal requests to internal, all others to IGW. Public subnet (ALB) needs a route table pointing internal requests to internal, all others to greater internet. Need between ECS container -> NAT Gateway, Need between NAT Gateway -> IGW


ALB routing vs Route Tables
- ALB Routing is for application level routing (/api/object -> fastapi-service-targetgroup). Application routing Layer 7
- Route table handles network routing (10.0.0.0/16 -> Local). Network routing Layer 3

AWS Firewall vs Security Group
- Firewall Network Layer7, only for ingress, only for http, https, 
- SG Layer 3,4. Instance level. Port or protocol based filtering. Inbound and outbound traffic control.

Web application firewall vs Security Group
- 
