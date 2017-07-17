#!/usr/bin/perl
use Net::Telnet::Cisco;

$num_args = $#ARGV + 1;
$defaultServer = "route-views.oregon-ix.net";
$defaultUser = "rviews";
$defaultPassword = "rviews";



if ($num_args == 0)
{
 print "Usage: ./bgp-show-subnet.pl <subnet>\n";
 print "   eg: ./bgp-show-subnet.pl 1.1.1.0/24\n";
 print "\n -- OR -- \n\n";
 print "Usage: ./bgp-show-subnet.pl <server> <user> <password> <subnet>\n";
 print "   eg: ./bgp-show-subnet.pl route-views.oregon-ix.net rviews pass 1.1.1.0/24\n";
 exit;
}

if ( $num_args <= 1 )
{
 $server = $defaultServer;
 $user = $defaultUser;
 $password = $defaultPassword;
 $subnet = $ARGV[0];
 print "[I] Using Default Router $defaultServer\n";
 print "[I] querying for subnet $subnet\n";
 print "[I]  - be patient, this can take some time\n";

}
else
{ 
 $server = $ARGV[0];
 $user = $ARGV[1];
 $password = $ARGV[2];
 $subnet = $ARGV[3];
}


#print "server: $server\n";

  my $session = Net::Telnet::Cisco->new(Host => $server , Timeout => 30);
  $session->login( $user , $password );

  $bgpCmd = "show ip bgp $subnet";
  #print "Command $bgpCmd\n";

  # Execute a command
  my @output = $session->cmd( $bgpCmd );
  print @output;


  $session->close;

