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
`pragma protect end_toolblock=""
`pragma protect begin_toolblock
`pragma protect rights_digest_method = "sha256"
`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinxt_2022_10", key_method = "rsa", key_public_key
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwifUMfX36AyhkNbimTSD
bD655sND8hrEntxBLxq6FukTVB5lXJlUMO9ASdWDsclUPlUYc2ZNi5rMSheXAeb9
hZuxAZF+ziGS9l5m12XwcUFLwy8/QLN5n/oxRQXlWXyvES//xwz4BTIVfLCFB0gq
5J1rh2R5KqLPUtfxv7D75A/oI5yNibtW/QmSXs1THkvg839ftyXbW3OUkAvB+tqg
DXKTIH6p/Lm0H4x1S5NucFVRrG8SsF6+0l03Gqc6F4sKlw++1TithusZfK2un1E1
50HktEX9e7GaXc6uL0zQ0QSss766nkTslv1ZJ7i2VEgGVD0WQv53Hx5zyRW5o4xD
/QIDAQAB
`pragma protect end_toolblock=""

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

