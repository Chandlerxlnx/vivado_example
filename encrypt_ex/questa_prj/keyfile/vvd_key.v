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
//`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinxt_2021_01", key_method = "rsa", key_public_key
//这里放密钥

`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinxt_2022_10", key_method = "rsa", key_public_key
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

