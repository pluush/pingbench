########################################
# Ping benchmark script by pluush      #
# v1.0 alpha 1                         #
# Copyright(C) 2017 - pluush           #
# github.com/pluush/pingbench          #
# NOTE: Scores are not comparable      #
# across different versions.           #
########################################

doping(){
pin=$(ping -w 2 $serv -c 1 | grep time= | awk -F = '{print $4}'); pinn=$(echo $pin | awk '{print $1}')
if ! [[ "$pinn" =~ ^[0-9.]+$ ]]; then pinn=0; count=""; else count="ok"; fi # Bad data check
echo "$pinn" >> /tmp/pingbench-ping.tmp
echo "$count" >> /tmp/pingbench-count.tmp
}

doping6(){
timeout6=0
if [ $serv6 = "NA" ]; then
pinn6=0; count6="" 
else
pin6=$(ping6 -w 2 $serv6 -c 1 | grep time= | awk -F = '{print $4}'); pinn6=$(echo $pin6 | awk '{print $1}')
if ! [[ "$pinn6" =~ ^[0-9.]+$ ]]; then pinn6=0; count6=""; else count6="ok"; fi # Bad data check
fi
echo "$pinn6" >> /tmp/pingbench-ping6.tmp
echo "$count6" >> /tmp/pingbench-count6.tmp
}

pingcalc(){
if [ $nip = 2 ]; then
rm /tmp/pingbench-ping.tmp -f
rm /tmp/pingbench-count.tmp -f
rm /tmp/pingbench-ping6.tmp -f
rm /tmp/pingbench-count6.tmp -f
doping & pid1=$!; doping & pid2=$!; doping & pid3=$!; doping & pid4=$!; doping & pid5=$!; doping & pid6=$!; doping & pid7=$!; doping & pid8=$!; doping & pid9=$!; doping & pid10=$!; doping6 & pid11=$!; doping6 & pid12=$!; doping6 & pid13=$!; doping6 & pid14=$!; doping6 & pid15=$!; doping6 & pid16=$!; doping6 & pid17=$!; doping6 & pid18=$!; doping6 & pid19=$!; doping6 & pid20=$!
wait $pid1; wait $pid2; wait $pid3; wait $pid4; wait $pid5; wait $pid6; wait $pid7; wait $pid8; wait $pid9; wait $pid10
wait $pid11; wait $pid12; wait $pid13; wait $pid14; wait $pid15; wait $pid16; wait $pid17; wait $pid18; wait $pid19; wait $pid20
eqn=$(cat /tmp/pingbench-ping.tmp); ttlt=$(echo $eqn | awk '{print $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10}')
count=$(cat /tmp/pingbench-count.tmp); n=$(echo "$count" | grep ok | sort | uniq -c | awk '{print $1}')
if ! [[ "$n" =~ ^[0-9]+$ ]]; then n=1; ttlt=0; fi 
res=$(echo "$ttlt $n" | awk '{print $1/$2}');
if [ "$res" = "0" ]; then resd="Timeout"; else resd="$res ms"; scount=$[$scount+1]; scountl=$[$scountl+1]; 
pingsum=$(echo "$pingsum $res" | awk '{print $1+$2}');
fi 
eqn6=$(cat /tmp/pingbench-ping6.tmp); ttlt6=$(echo $eqn6 | awk '{print $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10}')
count6=$(cat /tmp/pingbench-count6.tmp); n6=$(echo "$count6" | grep ok | sort | uniq -c | awk '{print $1}')
if ! [[ "$n6" =~ ^[0-9]+$ ]]; then n6=1; ttlt6=0; fi 
res6=$(echo "$ttlt6 $n6" | awk '{print $1/$2}');
if [ "$res6" = "0" ]; then resd6="Timeout"; else resd6="$res6 ms"; scount6=$[$scount+1]; scountl6=$[$scountl6+1]; 
pingsum6=$(echo "$pingsum6 $res6" | awk '{print $1+$2}');
fi 
lengthn=${#resd}
case $lengthn in
	'4')
		spacing="        ";;
	'5')
		spacing="       ";;
	'6')
		spacing="      ";;
	'7')
		spacing="     ";;
	'8')
		spacing="    ";;
	'9')
		spacing="   ";;
	'10')
		spacing="  ";;
	'11')
		spacing=" ";;
esac
fi
if [ $nip = 1 ]; then
 if [ $ip4e = 1 ]; then
 rm /tmp/pingbench-ping.tmp -f
 rm /tmp/pingbench-count.tmp -f
doping & pid1=$!; doping & pid2=$!; doping & pid3=$!; doping & pid4=$!; doping & pid5=$!; doping & pid6=$!; doping & pid7=$!; doping & pid8=$!; doping & pid9=$!; doping & pid10=$!; 
wait $pid1; wait $pid2; wait $pid3; wait $pid4; wait $pid5; wait $pid6; wait $pid7; wait $pid8; wait $pid9; wait $pid10
eqn=$(cat /tmp/pingbench-ping.tmp); ttlt=$(echo $eqn | awk '{print $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10}')
count=$(cat /tmp/pingbench-count.tmp); n=$(echo "$count" | grep ok | sort | uniq -c | awk '{print $1}')
if ! [[ "$n" =~ ^[0-9]+$ ]]; then n=1; ttlt=0; fi 
res=$(echo "$ttlt $n" | awk '{print $1/$2}');
if [ "$res" = "0" ]; then resd="Timeout"; else resd="$res ms"; scount=$[$scount+1]; scountl=$[$scountl+1]; 
pingsum=$(echo "$pingsum $res" | awk '{print $1+$2}');
fi 
 fi
 if [ $ip6e = 1 ]; then
 rm /tmp/pingbench-ping6.tmp -f
 rm /tmp/pingbench-count6.tmp -f
doping6 & pid11=$!; doping6 & pid12=$!; doping6 & pid13=$!; doping6 & pid14=$!; doping6 & pid15=$!; doping6 & pid16=$!; doping6 & pid17=$!; doping6 & pid18=$!; doping6 & pid19=$!; doping6 & pid20=$!
wait $pid11; wait $pid12; wait $pid13; wait $pid14; wait $pid15; wait $pid16; wait $pid17; wait $pid18; wait $pid19; wait $pid20
eqn6=$(cat /tmp/pingbench-ping6.tmp); ttlt6=$(echo $eqn6 | awk '{print $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10}')
count6=$(cat /tmp/pingbench-count6.tmp); n6=$(echo "$count6" | grep ok | sort | uniq -c | awk '{print $1}')
if ! [[ "$n6" =~ ^[0-9]+$ ]]; then n6=1; ttlt6=0; fi 
res6=$(echo "$ttlt6 $n6" | awk '{print $1/$2}');
if [ "$res6" = "0" ]; then resd6="Timeout"; else resd6="$res6 ms"; scount6=$[$scount+1]; scountl6=$[$scountl6+1]; 
pingsum6=$(echo "$pingsum6 $res6" | awk '{print $1+$2}');
fi 
 fi
fi
if [ "$serv6" = "NA" ]; then resd6="N/A"; fi
disp=$resd$spacing$resd6
if [ "$nip" = 1 ]; then
if [ "$ip4e" = 1 ]; then
disp=$resd
else
disp=$resd6
fi
fi
}

pingtest(){
nip=0
ip4e=0; ip6e=0
sip4=$( wget -qO- ipv4.icanhazip.com ) # Getting IPv4
if [ $ip4t = 1 ]; then
if [ ! -z "$sip4" ]; then nip=$[$nip+1]; ip4e=1; dsip4="Your public IPv4 is $sip4"; 
else dsip4="You don't have a working IPv4 address"; fi
fi
sip6=$( wget -qO- ipv6.icanhazip.com ) # Getting IPv6
if [ $ip6t = 1 ]; then
if [ ! -z "$sip6" ]; then nip=$[$nip+1]; ip6e=1; dsip6="Your public IPv6 is $sip6"; 
else dsip6="You don't have a working IPv6 address"; fi
fi
testipn=$[$ip4t + $ip6t];
if [ $testipn = 2 ]; then
hol="\n";
else hol=""
fi
if [ $nip = 2 ]; then
pingt="IPv4 avg    IPv6 avg"
wohoo="-----------------------------------------------------------------------------"
else pingt="Avg ping"
wohoo="-----------------------------------------------------------------"
fi
if [ $nip = 0 ]; then
echo "The test is not possible! You do not have a working IP address."
exit
fi

scount4=0; region4=0; scount6=0; region6=0 # Total server and region count

# Ping test via ping
echo " "
echo "$wohoo"
echo "Ping benchmark by plush (v1.0)"
echo -e "$dsip4$hol$dsip6"
echo "$wohoo"
echo " "
echo " "
echo "$wohoo"
echo "Test Region : CDN"
scountl=0; scountl6=0; pingsum4=0; pingsum6=0
echo "Description			Provider		$pingt"
echo "$wohoo"
serv="8.8.8.8"; serv6=2001:4860:4860::8888; pingcalc; resc00=$res; 
echo "Google DNS			Google			$disp"
serv="cachefly.cachefly.net"; serv6="NA"; pingcalc; 
echo "Cachefly CDN			Cachefly		$disp"
serv="cdn.teliacompany.com"; serv6="NA"; pingcalc; 
echo "Telia CDN Web			Telia			$disp"
serv="cloudflare.com"; serv6="cloudflare.com"; pingcalc; 
echo "Cloudflare Web			Cloudflare		$disp"
serv="facebook.com"; serv6="facebook.com"; pingcalc; 
echo "Facebook Web			Facebook		$disp"
echo "$wohoo"
if [ "$scountl" != "0" ] || [ "$scountl6" != "0" ]; then
if [ "$nip" = 2 ]; then
cdnavg=$(echo "$pingsum $scountl" | awk '{print $1/$2}');
echo "Successful servers IPv4 : $scountl / IPv6 : $scountl6"
cdnavg6=$(echo "$pingsum6 $scountl6" | awk '{print $1/$2}');
echo "Average ping IPv4 : $cdnavg ms / IPv6 : $cdnavg6 ms"
cdnavgnorm=$(echo "$cdnavg" | awk '{print $1+20}');
scorecdn=$(echo "$cdnavgnorm 200" | awk '{print exp(-$1/$2)*110.517091808}');
cdnavgnorm6=$(echo "$cdnavg6" | awk '{print $1+20}');
scorecdn6=$(echo "$cdnavgnorm6 200" | awk '{print exp(-$1/$2)*110.517091808}');
echo "IPv4 score : $scorecdn"
echo "IPv6 score : $scorecdn6"
scorecdnavg46=$(echo "$scorecdn $scorecdn6" | awk '{print $1/2 + $2/2}');
echo "Average score : $scorecdnavg46"
fi
if [ "$nip" = 1 ]; then
cdnavg=$(echo "$pingsum $scountl" | awk '{print $1/$2}');
echo "Successful servers : $scountl / Average ping : $cdnavg ms"
if [ "$ip6e" = 1 ]; then
cdnavgnorm6=$(echo "$cdnavg6" | awk '{print $1+20}');
scorecdn6=$(echo "$cdnavgnorm6 200" | awk '{print exp(-$1/$2)*110.517091808}');
echo "Score : $scorecdn"
else
cdnavgnorm=$(echo "$cdnavg" | awk '{print $1+20}');
scorecdn=$(echo "$cdnavgnorm 200" | awk '{print exp(-$1/$2)*110.517091808}');
echo "Score : $scorecdn"
fi
fi
cdns=1
else
cdns=0
echo "All servers are unreachable. Please check your firewall."
cdnavgnorm=0
scorecdn=0
err=1
err1="(CDN servers are unreachable) " 
fi

echo " "
echo " "
echo "$wohoo"
echo "Test Region : Americas"
scountl=0; pingsum4=0; pingsum6=0
echo "Location			Provider		Avg ping"
echo "$wohoo"
serv="repos.lax-noc.com"; pingcalc; res000=$res; 
echo "Los Angeles, CA, U.S.		QuadraNet		$resd"
serv="lg.lax.psychz.net"; pingcalc; res001=$res; 
echo "Los Angeles, CA, U.S.		Psychz			$resd"
serv="lax-ca-us-ping.vultr.com"; pingcalc; res002=$res; 
echo "Los Angeles, CA, U.S.		Choopa			$resd"
serv="lg.la.ramnode.com"; pingcalc; res003=$res; 
echo "Los Angeles, CA, U.S.		RamNode			$resd"
serv="speedtest.sjc01.softlayer.com"; pingcalc; res005=$res; 
echo "San Jose, CA, U.S.		RamNode			$resd"
serv="speedtest.fremont.linode.com"; pingcalc; res006=$res; 
echo "Freemont, CA, U.S.		Linode			$resd"
serv="speedtest-sfo1.digitalocean.com"; pingcalc; res007=$res; 
echo "San Francisco, CA, U.S.		DigitalOcean		$resd"
serv="sjo-ca-us-ping.vultr.com"; pingcalc; res008=$res; 
echo "Silicon Valley, CA, U.S.	Choopa			$resd"
serv="tx-us-ping.vultr.com"; pingcalc; res009=$res; 
echo "Dallas, TX, U.S.		Choopa			$resd"
serv="speedtest.dallas.linode.com"; pingcalc; res010=$res; 
echo "Dallas, TX, U.S.		Linode			$resd"
serv="lg.texas.psychz.net"; pingcalc; res011=$res; 
echo "Dallas, TX, U.S.		Psychz			$resd"
serv="il-us-ping.vultr.com"; pingcalc; res012=$res; 
echo "Chicago, IL, U.S.		Choopa			$resd"
serv="ga-us-ping.vultr.com"; pingcalc; res013=$res; 
echo "Atlanta, GA, U.S.		Choopa			$resd"
serv="speedtest.atlanta.linode.com"; pingcalc; res014=$res; 
echo "Atlanta, GA, U.S.		Linode			$resd"
serv="lg.atl.ramnode.com"; pingcalc; res015=$res; 
echo "Atlanta, GA, U.S.		RamNode			$resd"
serv="speed.atl.coloat.com"; pingcalc; res016=$res; 
echo "Atlanta, GA, U.S.		Coloat			$resd"
serv="wa-us-ping.vultr.com"; pingcalc; res017=$res; 
echo "Seattle, WA, U.S.		Choopa			$resd"
serv="lg.sea.ramnode.com"; pingcalc; res018=$res; 
echo "Seattle, WA, U.S.		RamNode			$resd"
serv="speedtest.sea01.softlayer.com"; pingcalc; res019=$res; 
echo "Seattle, WA, U.S.		Softlayer		$resd"
serv="nj-us-ping.vultr.com"; pingcalc; res020=$res; 
echo "New York, NY, U.S.		Choopa			$resd"
serv="lg.nyc.ramnode.com"; pingcalc; res021=$res; 
echo "New York, NY, U.S.		RamNode			$resd"
serv="speedtest-nyc3.digitalocean.com"; pingcalc; res022=$res; 
echo "New York, NY, U.S.		DigitalOcean		$resd"
serv="lg.buf.colocrossing.com"; pingcalc; res023=$res; 
echo "Buffalo, NY, U.S.		ColoCrossing		$resd"
serv="speedtest.newark.linode.com"; pingcalc; res024=$res; 
echo "Newark, NJ, U.S.		Linode			$resd"
serv="fl-us-ping.vultr.com"; pingcalc; res025=$res; 
echo "Miami, FL, U.S.			Choopa			$resd"
serv="speedtest.wdc01.softlayer.com"; pingcalc; res026=$res; 
echo "Washington, DC, U.S.		Softlayer		$resd"
serv="lg.va.psychz.net"; pingcalc; res027=$res; 
echo "Ashburn, VA, U.S.		Psychz			$resd"
serv="speedtest-tor1.digitalocean.com"; pingcalc; res028=$res; 
echo "Toronto, ON, Canada		DigitalOcean		$resd"
serv="ec2.sa-east-1.amazonaws.com"; pingcalc; res004=$res; 
echo "São Paulo, Brazil		Amazon Web Services	$resd"
echo "$wohoo"
if [ "$scountl" != "0" ]; then
ameavg=$(echo "$pingsum $scountl" | awk '{print $1/$2}');
scoreame=$(echo "$ameavg 400" | awk '{print exp(-$1/$2)*100}');
echo "Successful servers : $scountl / Average ping : $ameavg ms"
echo "Score : $scoreame"
region=$[$region+1]
else
echo "All servers are unreachable. Please check your firewall."
ameavg=0
scoreame=0
err=1
err2="(American servers are unreachable) " 
fi

echo " "
echo " "
echo "$wohoo"
echo "Test Region : Europe"
scountl=0; pingsum4=0; pingsum6=0
echo "Location			Provider		Avg ping"
echo "$wohoo"
serv="fra-de-ping.vultr.com"; pingcalc; res100=$res; 
echo "Frankfurt, Germany		Choopa			$resd"
serv="speedtest.frankfurt.linode.com"; pingcalc; res101=$res; 
echo "Frankfurt, Germany		Linode			$resd"
serv="ams-nl-ping.vultr.com"; pingcalc; res102=$res; 
echo "Amsterdam, Netherlands		Choopa			$resd"
serv="mirror.ams1.nl.leaseweb.net"; pingcalc; res103=$res; 
echo "Amsterdam, Netherlands		Leaseweb		$resd"
serv="lg.ams.psychz.net"; pingcalc; res104=$res; 
echo "Amsterdam, Netherlands		Psychz			$resd"
serv="par-fr-ping.vultr.com"; pingcalc; res105=$res; 
echo "Paris, France			Choopa			$resd"
serv="188.165.12.106"; pingcalc; res110=$res; 
echo "Roubaix, France			OVH			$resd"
serv="lon-gb-ping.vultr.com"; pingcalc; res106=$res; 
echo "London, U.K.			Choopa			$resd"
serv="speedtest.london.linode.com"; pingcalc; res107=$res; 
echo "London, U.K.			Linode			$resd"
serv="lg.lon.psychz.net"; pingcalc; res108=$res; 
echo "London, U.K.			Psychz			$resd"
serv="89.46.74.1"; pingcalc; res109=$res; 
echo "Arrezo, Italy			Aruba Cloud		$resd"
serv="81.2.236.1"; pingcalc; res111=$res; 
echo "Prague, Czech Republic		Aruba Cloud		$resd"
echo "$wohoo"
if [ "$scountl" != "0" ]; then
euavg=$(echo "$pingsum $scountl" | awk '{print $1/$2}');
scoreeu=$(echo "$euavg 400" | awk '{print exp(-$1/$2)*100}');
echo "Successful servers : $scountl / Average ping : $euavg ms"
echo "Score : $scoreeu"
region=$[$region+1]
else
echo "All servers are unreachable. Please check your firewall."
euavg=0
scoreeu=0
err=1
err3="(European servers are unreachable) " 
fi

echo " "
echo " "
echo "$wohoo"
echo "Test Region : Asia & Oceania (China excluded)"
scountl=0; pingsum4=0; pingsum6=0
echo "Location			Provider		Avg ping"
echo "$wohoo"
serv="sgp-ping.vultr.com"; pingcalc; res200=$res; 
echo "Singapore			Choopa			$resd"
serv="103.208.85.1"; pingcalc; res201=$res; 
echo "Singapore			Leaseweb		$resd"
serv="speedtest.singapore.linode.com"; pingcalc; res202=$res; 
echo "Singapore			Linode			$resd"
serv="speedtest.sng01.softlayer.com"; pingcalc; res203=$res; 
echo "Singapore			Softlayer		$resd"
serv="speedtest-sgp1.digitalocean.com"; pingcalc; res204=$res; 
echo "Singapore			DigitalOcean		$resd"
serv="sgp.infrastructures.ovh"; pingcalc; res205=$res; 
echo "Singapore			OVH			$resd"
serv="ec2.ap-northeast-2.amazonaws.com"; pingcalc; res214=$res; 
echo "Seoul, South Korea		Amazon Web Services	$resd"
serv="hnd-jp-ping.vultr.com"; pingcalc; res206=$res; 
echo "Tokyo, Japan			Choopa			$resd"
serv="cnh.romanrm.net"; pingcalc; res207=$res; 
echo "Tokyo, Japan			GMO Internet		$resd"
serv="speedtest.tokyo2.linode.com"; pingcalc; res208=$res; 
echo "Tokyo, Japan			Linode			$resd"
serv="ec2.ap-northeast-1.amazonaws.com"; pingcalc; res209=$res; 
echo "Tokyo, Japan			Amazon Web Services	$resd"
serv="59.106.1.129"; pingcalc; res210=$res; 
echo "Tokyo, Japan			SAKURA Internet		$resd"
serv="cp.tsukaeru.ne.jp"; pingcalc; res211=$res; 
echo "Nagano, Japan			Tsukaeru.net		$resd"
serv="103.75.117.1"; pingcalc; res212=$res; 
echo "Hong Kong			Leaseweb		$resd"
serv="103.78.122.171"; pingcalc; res213=$res; 
echo "Taipei, Taiwan			Psychz			$resd"
serv="speedtest-blr1.digitalocean.com"; pingcalc; res215=$res; 
echo "Bangalore, India		DigitalOcean		$resd"
serv="43.255.196.1"; pingcalc; res216=$res; 
echo "Jakarta, Indonesia		Telkom Indonesia	$resd"
vserv="syd-au-ping.vultr.com"; pingcalc; res217=$res; 
echo "Sydney, Australia		Choopa			$resd"
serv="syd.infrastructures.ovh"; pingcalc; res218=$res; 
echo "Sydney, Australia		OVH			$resd"
serv="ec2.ap-southeast-2.amazonaws.com"; pingcalc; res219=$res; 
echo "Sydney, Australia		Amazon Web Services	$resd"
echo "$wohoo"
if [ "$scountl" != "0" ]; then
asiavg=$(echo "$pingsum $scountl" | awk '{print $1/$2}');
echo "Successful servers : $scountl / Average ping : $asiavg ms"
scoreasi=$(echo "$asiavg 400" | awk '{print exp(-$1/$2)*100}');
echo "Successful servers : $scountl / Average ping : $asiavg ms"
echo "Score : $scoreasi"
region=$[$region+1]
else
echo "All servers are unreachable. Please check your firewall."
asiavg=0
scoreasi=0
err=1
err4="(Asian servers are unreachable) " 
fi

echo " "
echo " "
echo "$wohoo"
echo "Test Region : China (Chinese peering)"
scountl=0; pingsum4=0; pingsum6=0
echo "Location			Provider		Avg ping"
echo "$wohoo"
serv="120.26.207.1"; pingcalc; res300=$res; 
echo "Zhejiang, China			Alibaba Cloud		$resd"
serv="119.147.101.1"; pingcalc; res301=$res; 
echo "Guangdong, China		China Telecom		$resd"
serv="182.254.34.87"; pingcalc; res309=$res; 
echo "Guangdong, China		Tencent Cloud		$resd"
serv="115.159.101.72"; pingcalc; res302=$res; 
echo "Beijing, China			Tencent Cloud		$resd"
serv="ec2.cn-north-1.amazonaws.com.cn"; pingcalc; res310=$res; 
echo "Beijing, China			Amazon Web Services	$resd"
serv="222.77.179.216"; pingcalc; res303=$res; 
echo "Fuzhou, China			China Telecom		$resd"
serv="218.60.94.1"; pingcalc; res304=$res; 
echo "Liaoning, China			China Unicom		$resd"
serv="103.25.20.1"; pingcalc; res305=$res; 
echo "Beijing, China			China Unicom		$resd"
serv="125.39.240.113"; pingcalc; res306=$res; 
echo "Tianjin, China			China Unicom		$resd"
serv="112.29.173.1"; pingcalc; res307=$res; 
echo "Anhui, China			China Mobile		$resd"
serv="221.235.205.37"; pingcalc; res308=$res; 
echo "Hubei, China			China Telecom		$resd"
echo "$wohoo"
if [ "$scountl" != "0" ]; then
cnavg=$(echo "$pingsum $scountl" | awk '{print $1/$2}');
echo "Successful servers : $scountl / Average ping : $cnavg ms"
scorecn=$(echo "$cnavg 500" | awk '{print exp(-$1/$2)*100}');
echo "Score : $scorecn"
region=$[$region+1]
else
echo "All servers are unreachable. Please check your firewall."
cnavg=0
scorecn=0
err=1
err5="(Chinese servers are unreachable) " 
fi

echo " "
echo " "
echo "$wohoo"
if [ "$region" != 0 ]; then
regionalavg=$(echo "$ameavg $euavg $asiavg $cnavg $region" | awk '{print $1/$5 + $2/$5 + $3/$5 + $4/$5}');
echo "Regional average : $regionalavg ms"
total=$[$cdns+$region]
overalls=$(echo "$scorecdn $scoreame $scoreeu $scoreasi $scorecn $total" | awk '{print $1/$6 + $2/$6 + $3/$6 + $4/$6 + $5/$6}');
echo "Overall peering score : $overalls"
if [ "$err" = 1 ]; then
echo "Errors: $err1$err2$err3$err4$err5"
echo "If the test ended with errors, scores are not comparable, unless"
echo "the comparisons are made with other servers with the same error."
fi
else
echo "All servers are unreachable. Is your Internet off?"
fi
echo "$wohoo"
rm /tmp/pingbench-ping.tmp -f
rm /tmp/pingbench-count.tmp -f
}

ip4t=0; ip6t=0
case $1 in
	'-4')
		ip4t=1; ip6t=0; pingtest;;
	'-6')
		ip6t=1; ip4t=0; pingtest;;
	'-46')
		ip4t=1; ip6t=1; pingtest;;
	'-64')
		ip4t=1; ip6t=1; pingtest;;
	'-h' )
		hlp;;
	*)
		ip4t=1; ip6t=1; pingtest;;
esac
