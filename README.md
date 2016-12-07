# Pipelined-ARM-Processor

## Overview
The repository contains code for a **5-staged Pipelined Processor for the ARM language** which is written in VHDL. It works on 32 bit instructions and can implement the following instructions:  
+ **Branch** - \<b | bl\> {cond} \<destination\>  
+ **Add/Sub** - \<add | sub | rsb | adc | sbc | rsc> {cond} {s} Rn, Rd \<Op2\>  
+ **Logical** - \<and | orr | eor | bic> {cond} {s} Rn, Rd \<Op2\>  
+ **Test** - \<cmp | cmn | teq | tst> {cond} Rn \<Op2\>  
+ **Move** - \<mov | mvn> {cond} {s} Rd \<Op2\>  
+ **Multiply** - \<mul\> {cond} {s} Rd, Rm, Rs  
+ **Load/Store** - \<ldr | str> {cond} {b} Rd, # \<Imm12\>  

**Notation Used**  
+ **cond** - \<EQ | NE | CS | MI | PL | LS | VS | VC | HI | GE | LT | GT | LE | AL\>  
+ **destination** - 24 bit signed word-offset  
+ **Op2** - Rm{, \<LSL | LSR | ASR | ROR> #Imm5} or, \<#Imm32\>  
+ **Imm5** - 5 bit unsigned immediate  
+ **Imm12** - 12 bit signed immediate  
+ **Imm32** - 32 bit immediate encoded as 8 bit immediate with 4 bit shift amount  

## Components
THe processor consists of many smaller components that all gel together to carry out the instructions feeded into it. The high level component is named **Processor** which makes necessary calls to the actual components. The various components of the processor are listed below:  
+ **Instruction Memory** - This contains the instructions that have to fed to the processor. The processor will pick up an instruction from the instruction memory based on the current value of PC.  
+ **Register File** - This contiains a storage locations for items that need to be processed upon by the ALU. Currently there are 16 registers with some of them having special meaning. Eg. Link register and Stack register.  
+ **ALU** - This is the brains of the processor and all the arithmetic and logical operations take place in the ALU. It takes input from the Register File and genrerates an output.  
+ **Data Memory** - This holds the excess memory that the processor accesses time to time when it needs to process data not found in the registers. The output from the ALU can be stored in the Data Memory using a store operation. Similarly data from the fata memory can be loaded to a register using a load operation.  
+ **PC** -  This maintains the count of the current instruction that needs to be processed. The branch statement directly changes the PC value so that it can jump from one instruction directly to another. In general the PC updates its value by adding 1 every instruction cycle.
+ **Controller** -  This maintains all the flags and does all the equality checks. It manages the flow of data between the different components and helps with Data Hazards.

## The Pipeline
The Pipeline consists of 5 stages  
1) **Instruction Fetch**  
2) **Register Retrieval**  
3) **ALU Processing**  
4) **Data Memory Access**  
5) **Write-back to Register**  
The pipeline helps to reduce the number of clock cycles taken to reduce an instruction. However at times ongoing instructions might clash due to the clash of data resources. We call this a **Data Hazard**. Data Hazards are often solved using efficient data forwarding techniques which have been implemented in the processor in focus.

## Special Unit
We have tried to implement a special component which checks for an **error instruction** and also add the additional funcitonality of **division** and **modulo**. 

## Authors
* [Nikhil Gupta](https://github.com/NikhilGupta1997)
* [Ayush Bhardwaj](https://github.com/Ayushbh)

Course Project under [**Prof. Anshul Kumar**](http://www.cse.iitd.ac.in/~anshul/)
