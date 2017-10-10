########################################
# Ping benchmark script by pluush      #
# v0.3.3                               #
# Copyright(C) 2017 - pluush           #
########################################

doping(){
pin=$(ping -w 2 $serv -c 1 | grep time= | awk -F = '{print $4}')
pinn=$(echo $pin | awk '{print $1}')
if ! [[ "$pinn" =~ ^[0-9.]+$ ]]; then pinn=0; else count=$[$count+1];fi # Bad data check
}

pingcalc (){
count=0 # Successful ping counts
doping; pin0=$pin; pin0n=$pinn
doping; pin1=$pin; pin1n=$pinn
doping; pin2=$pin; pin2n=$pinn
doping; pin3=$pin; pin3n=$pinn
doping; pin4=$pin; pin4n=$pinn
doping; pin5=$pin; pin5n=$pinn
doping; pin6=$pin; pin6n=$pinn
doping; pin7=$pin; pin7n=$pinn
doping; pin8=$pin; pin8n=$pinn
doping; pin9=$pin; pin9n=$pinn
if [ "$count" = 0 ]; then pin1n=0; pin2n=0; pin3n=0; pin4n=0; pin5n=0; pin6n=0; pin7n=0; pin8n=0; pin9n=0; pin0n=0; count=1; fi 
res=$(echo "$pin0n $pin1n $pin2n $pin3n $pin4n $pin5n $pin6n $pin7n $pin8n $pin9n $count" | awk '{print $1/$11 + $2/$11 + $3/$11 + $4/$11 + $5/$11 + $6/$11 + $7/$11 + $8/$11 + $9/$11 + $10/$11}');
if [ "$res" = "0" ]; then resd="Timeout"; else resd="$res ms"; scount=$[$scount+1]; scountl=$[$scountl+1]; fi 
}

ip=$( wget -qO- ipv4.icanhazip.com ) # Getting IPv4
scount=0 # Non-timeout server count
region=0 # Region count

# Ping test via ping
echo " "
echo "-----------------------------------------------------------------"
echo "Ping benchmark by plush (v0.3.3)"
echo "Your public IPv4 is $ip"
echo "-----------------------------------------------------------------"
echo " "
echo " "
echo "-----------------------------------------------------------------"
echo "Test Region : CDN"
scountl=0 # Reset region server count
echo "Description			Provider		Avg ping"
echo "-----------------------------------------------------------------"
serv="8.8.8.8"; pingcalc; resc00=$res; 
echo "Google DNS			Google			$resd"
serv="cachefly.cachefly.net"; pingcalc; resc01=$res; 
echo "Cachefly CDN			Cachefly		$resd"
serv="cdn.teliacompany.com"; pingcalc; resc04=$res; 
echo "Telia CDN Web			Telia			$resd"
serv="cloudflare.com"; pingcalc; resc02=$res; 
echo "Cloudflare Web			Cloudflare		$resd"
serv="facebook.com"; pingcalc; resc03=$res; 
echo "Facebook Web			Facebook		$resd"
echo "-----------------------------------------------------------------"
if [ "$scountl" != "0" ]; then
cdnavg=$(echo "$resc00 $resc01 $resc02 $resc03 $resc04 $scountl" | awk '{print $1/$6 + $2/$6 + $3/$6 + $4/$6 + $5/$6}');
echo "Successful servers : $scountl / Average ping : $cdnavg ms"
cdnavgnorm=$(echo "$cdnavg" | awk '{print $1+20}');
scorecdn=$(echo "$cdnavgnorm 200" | awk '{print exp(-$1/$2)*110.517091808}');
echo "Score : $scorecdn"
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
echo "-----------------------------------------------------------------"
echo "Test Region : Americas"
scountl=0 # Reset region server count
echo "Location			Provider		Avg ping"
echo "-----------------------------------------------------------------"
serv="repos.lax-noc.com"; pingcalc; res000=$res; 
echo "Los Angeles, CA, U.S.		QuadraNet		$resd"
serv="lg.lax.psychz.net"; pingcalc; res001=$res; 
echo "Los Angeles, CA, U.S.		Psychz			$resd"
serv="lax-ca-us-ping.vultr.com"; pingcalc; res002=$res; 
echo "Los Angeles, CA, U.S.		Choopa			$resd"
serv="lg.la.ramnode.com"; pingcalc; res003=$res; 
echo "Los Angeles, CA, U.S.		RamNode			$resd"
serv="129.250.2.176"; pingcalc; res004=$res; 
echo "Los Angeles, CA, U.S.		NTT (Router)		$resd"
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
serv="198.50.175.241"; pingcalc; res029=$res; 
echo "Montréal, QC, Canada		OVH			$resd"
echo "-----------------------------------------------------------------"
if [ "$scountl" != "0" ]; then
ameavg=$(echo "$res000 $res001 $res002 $res003 $res004 $res005 $res006 $res007 $res008 $res009 $res010 $res011 $res012 $res013 $res014 $res015 $res016 $res017 $res018 $res019 $res020 $res021 $res022 $res023 $res024 $res025 $res026 $res027 $res028 $res029 $scountl" | awk '{print $1/$31 + $2/$31 + $3/$31 + $4/$31 + $5/$31 + $6/$31 + $7/$31 + $8/$31 + $9/$31 + $10/$31 + $11/$31 + $12/$31 + $13/$31 + $14/$31 + $15/$31 + $16/$31 + $17/$31 + $18/$31 + $19/$31 + $20/$31 + $21/$31 + $22/$31 + $23/$31 + $24/$31 + $25/$31 + $26/$31 + $27/$31 + $28/$31 + $29/$31 + $30/$31}');
echo "Successful servers : $scountl / Average ping : $ameavg ms"
scoreame=$(echo "$ameavg 400" | awk '{print exp(-$1/$2)*100}');
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
echo "-----------------------------------------------------------------"
echo "Test Region : Europe"
scountl=0 # Reset region server count
echo "Location			Provider		Avg ping"
echo "-----------------------------------------------------------------"
serv="fra-de-ping.vultr.com"; pingcalc; res100=$res; 
echo "Frankfurt, Germany		Choopa			$resd"
serv="speedtest.frankfurt.linode.com"; pingcalc; res101=$res; 
echo "Frankfurt, Germany		Linode			$resd"
serv="130.117.254.89"; pingcalc; res110=$res; 
echo "Berlin, Germany			Cogent (Router)		$resd"
serv="ams-nl-ping.vultr.com"; pingcalc; res102=$res; 
echo "Amsterdam, Netherlands		Choopa			$resd"
serv="mirror.ams1.nl.leaseweb.net"; pingcalc; res103=$res; 
echo "Amsterdam, Netherlands		Leaseweb		$resd"
serv="lg.ams.psychz.net"; pingcalc; res104=$res; 
echo "Amsterdam, Netherlands		Psychz			$resd"
serv="par-fr-ping.vultr.com"; pingcalc; res105=$res; 
echo "Paris, France			Choopa			$resd"
serv="lon-gb-ping.vultr.com"; pingcalc; res106=$res; 
echo "London, U.K.			Choopa			$resd"
serv="speedtest.london.linode.com"; pingcalc; res107=$res; 
echo "London, U.K.			Linode			$resd"
serv="lg.lon.psychz.net"; pingcalc; res108=$res; 
echo "London, U.K.			Psychz			$resd"
serv="89.46.74.1"; pingcalc; res109=$res; 
echo "Arrezo, Italy			Aruba Cloud		$resd"
serv="154.25.2.153"; pingcalc; res111=$res; 
echo "Rome, Italy			Cogent (Router)		$resd"
serv="130.117.254.145"; pingcalc; res112=$res; 
echo "Stockholm, Sweden		Cogent (Router)		$resd"
serv="130.117.254.137"; pingcalc; res113=$res; 
echo "Copenhagen, Denmark		Cogent (Router)		$resd"
serv="81.2.236.1"; pingcalc; res114=$res; 
echo "Prague, Czech Republic		Aruba Cloud		$resd"
echo "-----------------------------------------------------------------"
if [ "$scountl" != "0" ]; then
euavg=$(echo "$res100 $res101 $res102 $res103 $res104 $res105 $res106 $res107 $res108 $res109 $res110 $res111 $res112 $res113 $res114 $scountl" | awk '{print $1/$16 + $2/$16 + $3/$16 + $4/$16 + $5/$16 + $6/$16 + $7/$16 + $8/$16 + $9/$16 + $10/$16 + $11/$16 + $12/$16 + $13/$16 + $14/$16 + $15/$16}');
echo "Successful servers : $scountl / Average ping : $euavg ms"
scoreeu=$(echo "$euavg 400" | awk '{print exp(-$1/$2)*100}');
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
echo "-----------------------------------------------------------------"
echo "Test Region : Asia & Oceania (China excluded)"
scountl=0 # Reset region server count
echo "Location			Provider		Avg ping"
echo "-----------------------------------------------------------------"
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
serv="core1.sel1.he.net"; pingcalc; res220=$res; 
echo "Seoul, South Korea		HE.net (Router)		$resd"
serv="hnd-jp-ping.vultr.com"; pingcalc; res206=$res; 
echo "Tokyo, Japan			Choopa			$resd"
serv="cnh.romanrm.net"; pingcalc; res207=$res; 
echo "Tokyo, Japan			GMO Internet		$resd"
serv="speedtest.tokyo2.linode.com"; pingcalc; res208=$res; 
echo "Tokyo, Japan			Linode			$resd"
serv="az.romanrm.net"; pingcalc; res209=$res; 
echo "Tokyo, Japan			Amazon Web Services	$resd"
serv="129.250.5.48"; pingcalc; res210=$res; 
echo "Osaka, Japan			NTT (Router)		$resd"
serv="cp.tsukaeru.ne.jp"; pingcalc; res211=$res; 
echo "Nagano, Japan			Tsukaeru.net		$resd"
serv="103.75.117.1"; pingcalc; res212=$res; 
echo "Hong Kong			Leaseweb		$resd"
serv="202.84.157.18"; pingcalc; res222=$res; 
echo "Hong Kong			Telstra (Router)	$resd"
serv="lg.tw.psychz.net"; pingcalc; res213=$res; 
echo "Taipei, Taiwan			Psychz			$resd"
serv="129.250.2.82"; pingcalc; res214=$res; 
echo "Taipei, Taiwan			NTT (Router)		$resd"
serv="speedtest-blr1.digitalocean.com"; pingcalc; res215=$res; 
echo "Bangalore, India		DigitalOcean		$resd"
serv="129.250.7.42"; pingcalc; res216=$res; 
echo "Kuala Lumpur, Malaysia		NTT (Router)		$resd"
serv="43.255.196.1"; pingcalc; res221=$res; 
echo "Jakarta, Indonesia		Telkom Indonesia	$resd"
vserv="syd-au-ping.vultr.com"; pingcalc; res217=$res; 
echo "Sydney, Australia		Choopa			$resd"
serv="syd.infrastructures.ovh"; pingcalc; res218=$res; 
echo "Sydney, Australia		OVH			$resd"
serv="202.68.64.214"; pingcalc; res219=$res; 
echo "Sydney, Australia		NTT (Router)		$resd"
echo "-----------------------------------------------------------------"
if [ "$scountl" != "0" ]; then
asiavg=$(echo "$res200 $res201 $res202 $res203 $res204 $res205 $res206 $res207 $res208 $res209 $res210 $res211 $res212 $res213 $res214 $res215 $res216 $res217 $res218 $res219 $res220 $res221 $res222 $scountl" | awk '{print $1/$24 + $2/$24 + $3/$24 + $4/$24 + $5/$24 + $6/$24 + $7/$24 + $8/$24 + $9/$24 + $10/$24 + $11/$24 + $12/$24 + $13/$24 + $14/$24 + $15/$24 + $16/$24 + $17/$24 + $18/$24 + $19/$24 + $20/$24 +  $21/$24 + $22/$24 + $23/$24}');
echo "Successful servers : $scountl / Average ping : $asiavg ms"
scoreasi=$(echo "$asiavg 400" | awk '{print exp(-$1/$2)*100}');
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
echo "-----------------------------------------------------------------"
echo "Test Region : China (Chinese peering)"
scountl=0 # Reset region server count
echo "Location			Provider		Avg ping"
echo "-----------------------------------------------------------------"
serv="120.26.207.1"; pingcalc; res300=$res; 
echo "Zhejiang, China			Alibaba Cloud		$resd"
serv="119.147.101.1"; pingcalc; res301=$res; 
echo "Guangdong, China		China Telecom		$resd"
serv="115.159.101.72"; pingcalc; res302=$res; 
echo "Beijing, China			Tencent Cloud		$resd"
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
serv="182.254.34.87"; pingcalc; res309=$res; 
echo "Guangdong, China		Tencent Cloud		$resd"
echo "-----------------------------------------------------------------"
if [ "$scountl" != "0" ]; then
cnavg=$(echo "$res300 $res301 $res302 $res303 $res304 $res305 $res306 $res307 $res308 $res309 $scountl" | awk '{print $1/$11 + $2/$11 + $3/$11 + $4/$11 + $5/$11 + $6/$11 + $7/$11 + $8/$11 + $9/$11 + $10/$11}');
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
echo "-----------------------------------------------------------------"
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
echo "-----------------------------------------------------------------"
