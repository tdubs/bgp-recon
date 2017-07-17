# bgp-recon
BGP Recon consists of four perl scripts used to identify all the subnets and BGP Autonomous System Numbers of your target organization.

First we want  start with any subnets associated with the target organization and run
bgp-show-subnet.pl
Save the output and parse it with bgp-subnet-parse.pl

Then we want to identify all the subnets as

# Required libraries:
apt-get install libnet-telnet-cisco-perl 

# Example Useage

./bgp-show-subnet.pl route-views.oregon-ix.net rviews pass 216.252.220.0/22 > subnet.out.txt



######### TO ADD ########
Show ASNs just before target ASN to obtain Internet gateway peers

