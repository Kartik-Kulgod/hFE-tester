#make_bin#

#LOAD_SEGMENT=FFFFh#
#LOAD_OFFSET=0000h#

#CS=0000h#
#IP=0000h#

#DS=0000h#
#ES=0000h#

#SS=0000h#
#SP=3FFEh#

#AX=0000h#
#BX=0000h#
#CX=0000h#
#DX=0000h#
#SI=0000h#
#DI=0000h#
#BP=0000h#

; add your code here
         jmp     st1 
         nop
         dw      0000
         dw      0000
         dw      ad_isr
         dw      0000
		                        
		 db     1012 dup(0)
;main program
          
st1:      cli 
; intialize ds, es,ss to start of RAM
          mov       ax,0200h
          mov       ds,ax
          mov       es,ax
          mov       ss,ax
          mov       sp,0FFFEH 
          
;intialise porta  as input & b& c as output
          mov       al,90h
		  out 		0eh,al 
		  
		  mov       al,90h
		  out       06h,al
		  ;call dela
		  mov dl,5
		  call idec
		  ;call iinc
		  ;call iinc
		  
		  bgin:nop
		  nop
		  nop
		  mov al,01000000b
          out 04h,al
		  
		  
;select ch0
		  mov		al,00
		  out		0ch,al  
;give ale  
          mov       al,00100000b
		  out       0ch,al 
		 
;give soc  
          mov		al,00110000b
		  out		0ch,al 
		  
		  nop
		  nop
		  nop
		  nop
;make soc 0 
		  mov       al,00010000b
		  out       0ch,al  
;make ale 0
		  
		  mov       al,00000000b
		  out       0ch,al
		  
		  
		  nop
		  nop
		  nop
		  nop
		  nop
		  nop
		  nop
		  nop
		  nop
		  ;call iinc
		  ;call dela
		  ;cmp dl,11
		  ;jnz bgin
       
		  
		       
                    
		  
		             
		      
		  
x2:       jmp       x2 

ad_isr:   ;mov al,01000001b
          ;out 04h,al
          mov		al,00001000b
		  out		0ch,al
		  in        al,08h
;		  mov       bl,al
;		  mov       al,bl
    	  mov 		cl, 11111111b
		  sub 		cl,al
	      mov 		al,cl
		  mov 		cl,20
		  mul 		cl 
		  div       dl  ;quotient in al
		  xor       ah,ah; remove remainder
		  mov 		cl,100
		  div 		cl   ; quotient in al
		  out       02h,al; display it
		  mov bl,al
		  mov       al,ah ;move remainder to al
		  mov       cl,10  
		  xor       ah,ah
		  div       cl; al contains 10 digit, ah contains 1 digit
;		  and       al,0fh
;		  and       ah,0fh
          cmp bl,0
          jnz noal
          cmp al,2
          jae noal  
          mov bl,al
          mov al,01000001b
          out 04h,al
          rpt:in  al,00h
          and al,80h
          cmp al,80h
          jnz rpt 
          mov al,01000000b
          out 04h,al
          rpt2:in  al,00h
          and al,80h
          cmp al,00h
          jnz rpt2
          mov al,bl
		  noal:shl       al,4
		  or        al,ah
		  out       0ah,al	   
         iret
                
       iinc proc
            ;proc to increase voltage by 0.5V
		            mov cx,13
              x3:   mov al,10000000b
                    out 04h,al
                    mov al,10100000b
                    out 04h,al
                    nop
                    nop
                    mov al,10000000b
                    out 04h,al
                    loop x3
                    mov al,01000000b
                    out 04h,al                     
                    inc dl 
                    
                    nop
                    nop
                    nop 
                    ret
        iinc endp

    

        idec proc
           ; roc to decrease voltage by 0.5V
		            mov cx,13
              x3d:  mov al,00000000b
                    out 04h,al
                    mov al,00100000b
                    out 04h,al
                    nop
                    nop
                    
                    mov al,00000000b
                    out 04h,al  
                    
                    loop x3d
                    mov al,01000000b
                    out 04h,al                     
                    dec dl 
                    
                    nop
                    nop
                    nop 
            ret
        idec endp
        dela proc
           mov si,1
           s1: mov di,1000
           ;b1:nop
           d1:dec di
           cmp di,0
           jnz d1
           dec si
           cmp si,0
           jnz s1
           ret
        dela endp
        