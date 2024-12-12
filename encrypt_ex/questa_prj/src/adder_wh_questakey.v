`pragma protect version = 2
`pragma protect begin_commonblock
`pragma protect end_commonblock
`pragma protect begin_toolblock
`pragma protect key_keyowner="Siemens"
`pragma protect key_keyname="SIEMENS-VERIF-SIM-RSA-2"
`pragma protect key_method="rsa"
`pragma protect rights_digest_method = "sha256"
`pragma protect key_public_key
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx+k+qA5XYbKGz7OB2dvm
zKfSz1pu6AdBOqTfSozf9O4OMKPkbXBrRWFvCCDTXh93KZAHkXy4MjruMaX2GZVO
zb88BMWaZBd5EfHBLUOjUZNQARtG0birIXXJxF3d9OWFmkaS/LKlY7z/NKpuGawh
Z1r3h43ZxAsq6F3ZmxLuIwOSDNE+rvcOp4Y1nt330BzS/3deXr3AyCDveRh015II
XJIHpbGFAuCa4z8P5GMUso01O1EREnVoIoCvx8lGLoAIYGYFawKjK7dOXGCbU7qc
VmyPExL0cTfeeXApDNTUQAwvifj8Pjmfe+7dOfTqY9ZQsCHWO/Uto7ERjzb2RCTS
TQIDAQAB
`pragma protect end_toolblock

`pragma protect begin
module adder(
   input clk,
   input rst,
   input [7:0] a_in,
   input [7:0] b_in,
   output reg[8:0] sum_o
);

`pragma protect viewport
  always@(posedge clk or posedge rst)
  if(rst) sum_o <=0;
  else sum_o <= a_in + b_in;

endmodule

`pragma protect end
