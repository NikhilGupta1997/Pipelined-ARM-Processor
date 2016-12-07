# Pipelined-ARM-Processor

## Overview
The repository contains code for a **5-staged Pipelined Processor for the ARM language**. It works on 32 bit instructions and can implement the following instructions:  
+ **Branch** - \<b | bl\> {cond} \<destination\>  
+ **Add/Sub** - \<add | sub | rsb | adc | sbc | rsc> {cond} {s} Rn, Rd \<Op2\>  
+ **Logical** - \<and | orr | eor | bic> {cond} {s} Rn, Rd \<Op2\>  
+ **Test** - \<cmp | cmn | teq | tst> {cond} Rn \<Op2\>  
+ **Move** - \<mov | mvn> {cond} {s} Rd \<Op2\>  
+ **Multiply** - \<mul\> {cond} {s} Rd, Rm, Rs  
+ **Load/Store** - \<ldr | str> {cond} {b} Rd, # \<Imm12\>  

**Notation**  
+ **cond** - \<EQ | NE | CS | MI | PL | LS | VS | VC | HI | GE | LT | GT | LE | AL\>  
+ **destination** - 24 bit signed word-offset  
+ **Op2** - Rm{, \<LSL | LSR | ASR | ROR> #Imm5} or, \<#Imm32\>  
+ **Imm5** - 5 bit unsigned immediate  
+ **Imm12** - 12 bit signed immediate  
+ **Imm32** - 32 bit immediate encoded as 8 bit immediate with 4 bit shift amount  
