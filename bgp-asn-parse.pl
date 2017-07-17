#!/usr/bin/perl

#
# Mangle script for dnsrecon
# expects csv output from dnsrecon
#

# Specifies the source STEPUID of the input file eg RECON_1.1
$CMDSRC = @ARGV[1];
$INFILE = @ARGV[0];

if ( ! $CMDSRC )
{
 $CMDSRC = "manual";
}

#printf "[i] Opening ifile: $infile\n";
open(INFILE, $INFILE) || die("Could not open $INFILE");

#
# Need to print our header first
# note that these header values must 
# match the actual name of the GRID fields!
#
#print "cidrSubnet,BGPASN,cmdSrc\n";

sub uniq {
  my %seen;
  return grep { !$seen{$_}++ } @_;
}
@ASN = "";
@PEERS = "";

$TARGETLINE = "NO";
$lineCnt = 1;

@subnets = "";

while (<INFILE>) {

 $line = $_;
 if ( $lineCnt > 4 )
 {
  if ( $line =~ /\s+([\d\.]+)\s+(.?)$/gi ) 
  {
   $asn = $1;
   #print "ASN: $asn\n";
  }
 }

 #BGP routing table entry for 1.1.1.1/16, version 235941
 # *   12.6.208.0/20    192.241.164.4   
 # if ( $_ =~ /^(\s+)\*\s\s\s([\d\.]+)(?:\/(?:[0-9]|[1-2][0-9]|3[0-2]))\s+(.*)/gi ) {
 # if ( $_ =~ /^(\s+)\*\s\s\s([\d\.]+\/(?:[0-9]|[1-2][0-9]|3[0-2]))\s+(.*)/gi ) {
   if ( $_ =~ /^(\s+)\*\s\s\s([\d\.]+?\/(?:[0-9]|[1-2][0-9]|3[0-2]))\s+(.*)/gi ) {

       $subnet =  $2;
     #printf "[+]$subnet \n";
     #print "$subnet,$asn,$CMDSRC\n";
     print "ASN: $asn, Subnet: $subnet\n";

 }
 $lineCnt++;
}


