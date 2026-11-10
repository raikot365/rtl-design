timescale

`timescale 1ns/1ps //time unit / time precision

- The time precision is specified to be 1ns and hence the simulator cannot go smaller than 1 ns which makes it to round the given delay statement and yields 0ns
- timescale 1ns/1ps means whatever time you mention in your test bench will be taken in " ns",
- Eg: # 10 as 10 ns.
- Precision of 1ps means you can have "# 0.001 " as "# 0.001 ns/1ps ", but "# 0.00013" means 0 ns.

- 1 ns = 1000 ps
- 1 ps = 0.001 ns