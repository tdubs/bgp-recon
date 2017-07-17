#!/usr/bin/perl
# Specifies the source STEPUID of the input file eg RECON_1.1
#$CMDSRC = @ARGV[1];
$INFILE = @ARGV[0];


# recordChk, cidrSubnet, cidrNetName, cidrOrgName, BGPASN, cmdSrc

#if ( ! $CMDSRC )
#{
# $CMDSRC = "manual";
#}


printf "[+] Opening file: $INFILE\n";
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

while (<INFILE>) {
  
 #BGP routing table entry for 1.1.1.1/16, version 235941
 if ( $_ =~ /routing table entry for (.*),/gi ) {
       $subnet =  $1;
     printf "[+] Identified Subnet $1\n";
 }

 if ( $TARGETLINE eq "YES" )
 {
   chomp($_);
   if ( $_ =~ /(\d*)\s(\d*)$/gi ) {
    #print "1 $1 | 2 $2 \n"; 
	  $_;
    push( @ASN, $2);
    push( @PEERS, $1);
   }
  
   # 202018 2914 3356, (aggregated by 3356 4.69.130.82)
   # if ( $_ =~ /(\d*)\s(\d*).*\(aggregated by (\d*)/gi ) {
  if ( $_ =~ /.*\(aggregated by (\d*).*/gi ) { 
     #print "Debug $1\n";
     push( @ASN, $1);
     #push( @PEERS, $1);
   }

   $TARGETLINE = "NO";
 }

 if ( $_ =~ /Refresh Epoch/gi ) {
       $line =  $2;
     #printf "[+] Found Epoch line\n";
     $TARGETLINE = "YES";  
 }
}

@unique_ASNS = uniq @ASN;
@unique_PEERS = uniq @PEERS;

print "Subnet,ASN\n";

foreach $asn (@unique_ASNS )
{
 if ( $asn != "" )
 {
 #print "$subnet, ASN: $asn\n";
 print "$subnet,$asn\n";
 }
}

foreach $peer (@unique_PEERS )
{
 if ( $peer != "" )
 {
 #print "$subnet, PEER: $peer\n";
 }
}


