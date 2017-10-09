# pingbench
Tests general peering performance by comparing pings across publicly available test servers.
This script compares pings to multiple regions (North America, Europe, Asia & Oceania).

Run the benchmark by running this one-liner (requires wget):

    wget https://pluush.github.io/pingbench/pingbench.sh -O - -o /dev/null | bash

This script will give you a score between 0 to 100, but both ends are not achieveable under real-world conditions.
A higher score would mean better overall peering. Sample use case for this script is when you want to find a good proxy / VPN server with a good connection worldwide. This can also be effective if you want to choose an ISP for gaming, host game servers, or just run latency-critical apps.

Suggestions would be great!
