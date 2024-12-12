`pragma protect version = 2
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2021"
`pragma protect begin_commonblock
`pragma protect control error_handling = "delegated"
`pragma protect control child_visibility = "delegated"
`pragma protect control decryption = (activity==simulation)? "false" :"true"
`pragma protect end_commonblock

`pragma protect begin_toolblock
`pragma protect rights_digest_method="sha256"
`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinxt_2022_10", key_method = "rsa"
`pragma protect key_block
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwifUMfX36AyhkNbimTSD
bD655sND8hrEntxBLxq6FukTVB5lXJlUMO9ASdWDsclUPlUYc2ZNi5rMSheXAeb9
hZuxAZF+ziGS9l5m12XwcUFLwy8/QLN5n/oxRQXlWXyvES//xwz4BTIVfLCFB0gq
5J1rh2R5KqLPUtfxv7D75A/oI5yNibtW/QmSXs1THkvg839ftyXbW3OUkAvB+tqg
DXKTIH6p/Lm0H4x1S5NucFVRrG8SsF6+0l03Gqc6F4sKlw++1TithusZfK2un1E1
50HktEX9e7GaXc6uL0zQ0QSss766nkTslv1ZJ7i2VEgGVD0WQv53Hx5zyRW5o4xD
/QIDAQAB
`pragma protect control xilinx_configuration_visible = "false"
`pragma protect control xilinx_enable_modification = "false"
`pragma protect control xilinx_enable_probing = "false"
`pragma protect control xilinx_enable_netlist_export = "false"
`pragma protect control xilinx_enable_bitstream = "true"
`pragma protect control decryption = (xilinx_activity==simulation)?"false" : "true"
`pragma protect end_toolblock = ""

`pragma protect begin_toolblock
`pragma protect key_keyowner = "Mentor Graphics Corporation", key_method = "rsa", key_keyname = "MGC-PREC-RSA"
`pragma protect key_block
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArTSsjbL7NZvZ6c7x07D7
Zu4vJ9pnWrCgJAsEbmvc4TQ+qkL1cxtMEriJnSSBm6wVsQVShqxd/WsZkSCZJ709
zdripXSSXEIZZRxXeY2FhSVoiIJYdEyDs5IHJkgr3I5AjEn5UD/2VF3h4Uv6tEW6
wlMrCDcsDaUm+G5b4YtBhQv1yMEb2wan8gDg22sJ37E8B/V4LLg+G7EPKY4lQ1aE
kaj6wr04hQEuwa3Eus0rJtHUvX+fTsTg/kiMnYZo2U1TKYY+48vDkRE1x9HBmEXk
m+cmOK/95eZZj6LBsqwywoRgBjiE+lbdzkPy3/A7vQzi+CEk0wZQs4AGWZkCh0gL
zwIDAQAB

`pragma protect end_toolblock
