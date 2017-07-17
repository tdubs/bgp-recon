#!/usr/bin/perl
use Net::Telnet::Cisco;

$num_args = $#ARGV + 1;
$defaultServer = "route-views.oregon-ix.net";
$defaultUser = "rviews";
$defaultPassword = "rviews";


if ($num_args == 0)
{
 print "Usage: ./bgp-show-asn.pl <asn>\n";
 print "   eg: ./bgp-show-asn.pl 1234\n";
 print "\n -- OR -- \n\n";
 print "Usage: ./bgp-show-asn.pl <server> <user> <password> <asn>\n";
 print "   eg: ./bgp-show-asn.pl route-views.oregon-ix.net rviews pass 123\n";
 exit;
}

if ( $num_args <= 1 )
{
 $server = $defaultServer;
 $user = $defaultUser;
 $password = $defaultPassword;
 $asn = $ARGV[0];
 print "[I] Using Default Router $defaultServer\n";
 print "[I] querying for ASN $asn\n";
 print "[I]  - be patient, this can take some time\n";

}
else
{ 
 $server = $ARGV[0];
 $user = $ARGV[1];
 $password = $ARGV[2];
 $asn = $ARGV[3];
}


#print "server: $server\n";

  my $session = Net::Telnet::Cisco->new(Host => $server , Timeout => 90);
  $session->login( $user , $password );

  $bgpCmd = "show ip bgp regexp _$asn\$";
  #print "Command $bgpCmd\n";

  # Execute a command
  my @output = $session->cmd( $bgpCmd );
  print @output;


  $session->close;

