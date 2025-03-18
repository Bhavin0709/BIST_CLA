# BIST_CLA

Our BIST controller Works in the following two modes:
**- Mode 0 (Normal Mode):** In this mode, the CLA generates the output leading to Golden Signature
**- Mode 1 (Test Mode):** In this mode, the CLA generates the output leading to the Faulty Signature and the comparison takes place with the Golden signature.

We have taken two LFSR (type1) to generate test vectors for both the inputs of CLA (A & B - CUT), we 
have kept an ENL signal which enables both the type 1 LFSR’s.

The Output of the CUT(CLA) goes into SISR (LFSR type 2) which generates a 4bit signature when ENS
(Enable SISR) signal is enable.

The ENC signal functions as a flag during signature generation in the Serial Input Shift Register (SISR). 
When processing a specific pattern, the ENC signal is initially low. Upon completion of signature 
generation, the ENC signal transitions to a high state. Consequently, the detection of a high ENC 
signal by the comparator or memory indicates that a signature has been successfully generated at 
the output of the SISR.
