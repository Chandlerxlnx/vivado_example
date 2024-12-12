
#Error
1. error message:
```
ERROR: [Designutils 20-2361] Syntax error in IEEE-1735 encryption envelope.  Expecting <eol>
//` pragma protect control error_handling = "delegated"
---^- here [./src/adder_mult_key.v:5]
```
* root cause: no `//` comments allowed in encryption evelope
  - wrong code:
```C
`pragma protect begin_commonblock
//` pragma protect control error_handling = "delegated"
// ` pragma protect control child_visibility = "delegated"
//` pragma protect control decryption = (activity==simulation)? "false" :"true"
`pragma protect end_commonblock

```
  - correct code:
```C
`pragma protect begin_commonblock
`pragma protect end_commonblock

```
2. Warning message:
```
===create embedded multi key file encrypted by questa
QuestaSim-64 vencrypt 2024.1 Encryption Utility 2024.02 Feb  1 2024
vencrypt ./src/adder_wh_key.v -o ./encrypted_src/adder_wh_key.vp 
Reading ./src/adder_wh_key.v
** Warning: ./src/adder_wh_key.v(28): (vencrypt-14179) Protect directive "end_toolblock" should not have a digest.
Encrypting (1) into ./encrypted_src/adder_wh_key.vp.

```
  - wrong code:
```
`pragma protect end_toolblock
```
  - correct code:
```
`pragma protect end_toolblock=""
```
3. # encrypt  -ext .vp -lang verilog ./src/adder_wh_questakey.v
ERROR: [Designutils 20-2361] Syntax error in IEEE-1735 encryption envelope.  Expecting "="
`pragma protect begin
-^- here [./src/adder_wh_questakey.v:19]
ERROR: [Vivado 12-3330] encrypt 1735: Failed to encrypt './src/adder_wh_questakey.v': FileStructure::encrypt1735: 
 - Wrong code:
```
`pragma protect end_toolblock
```
 - correct code:
```
`pragma protect end_toolblock=""
```
