       identification division.
       program-id. Inventory_Pegging.
       AUTHOR. DAVE Gerson.    
       INSTALLATION. CITI.
       DATE-WRITTEN. 8/19/2014.
       DATE-COMPILED.
       SECURITY.      LOCAL GROUP.

       environment division.
       Input-Output Section.
       File-Control.
           Select itemmaster assign 'E:\MRP_Shampoo\ItemMaster.txt'
                  ORGANIZATION IS LINE SEQUENTIAL.
           Select Bill-o-Mat assign 'E:\MRP_Shampoo\BOM.txt'
                  ORGANIZATION IS LINE SEQUENTIAL.                  
           Select outfile assign 'E:\MRP_Shampoo\OUT.txt'.
       configuration section.
       
       Data Division.
       File Section.
       fd itemmaster.
       01 ITEM-RECORD.
          03 ITEM-CODE PIC x(5).
          03 ITEM-DESC PIC x(26).
          03 ITEM-UOM PIC   x(6).
          03 ITEM-WHS PIC   x(2).
          03 ITEM-VAD PIC   x(4).
          03 ITEM-VADNAME PIC   x(18).
          03 ITEM-LEADTIME PIC   9(4).
          03 FILLER PIC x.
          03 ITEM-STOCK PIC   9(7).       
       fd Bill-o-Mat.
       01 BOM-Record.
          03 BOM-TOPLVL-ITEM-CODE PIC x(5).
          03 FILLER PIC x.   
          03 BOM-COMPLVL-ITEM-CODE PIC x(5).
          03 FILLER PIC x.
          03 BOM-RATIO PIC   99V999.          
       fd outfile.
       01 out-ITEM-RECORD.
          03 out-ITEM-CODE PIC x(5).
          03 out-ITEM-DESC PIC x(26).
          03 out-ITEM-UOM PIC   x(6).
          03 out-ITEM-WHS PIC   x(2).
          03 out-ITEM-VAD PIC   x(4).
          03 out-ITEM-VADNAME PIC   x(18).
          03 out-ITEM-LEADTIME PIC   9(4).
          03 out-ITEM-STOCK PIC   9(7).       

       01 out-BOM-Record.
          03 out-BOM-TOPLVL-ITEM-CODE PIC x(5).
          03 FILLER PIC x.   
          03 out-BOM-COMPLVL-ITEM-CODE PIC x(5).
          03 FILLER PIC x.
          03 out-BOM-RATIO PIC   99V999.    
       working-storage section.
       01 TEXT-OUT    PIC X(27) VALUE '###########################'.
       
       
       01  ws-numerics             comp value low-values.
           03  item-eof-flag         pic 9.
           03  item-row-counter    pic 9(4).
           03  bom-eof-flag         pic 9.
           03  bom-row-counter    pic 9(4).
           
       procedure division.
           display TEXT-OUT
-           TEXT-OUT.
       000-Main Section.
       000-begin.
           open input itemmaster.
           open input Bill-o-Mat.
           open output outfile.
           perform item-reader-writer until item-eof-flag = 1.
*           perform bom-reader-writer until bom-eof-flag = 1.
           close itemmaster outfile Bill-o-Mat.
           stop 'Press <CR> to terminate'       
           STOP RUN.

       item-reader Section.
           read itemmaster
               at end set item-eof-flag to 1 *> notice the SET statement
           end-read.         
           
           
       item-reader-writer Section.
       010-begin.
           perform item-reader.
           add 1 to item-row-counter.
           display 'RECORD COUNT ' 
           item-row-counter '#################'.
           display 'Item Code            :' ITEM-CODE.
           display 'Item Description     :' ITEM-DESC.
           display 'Item Unit Of Measure :' ITEM-UOM.
           display 'Item Warehouse       :' ITEM-WHS.
           display 'Item Vendor          :' ITEM-VAD.
           display 'Item Vendor Name     :' ITEM-VADNAME.
           display 'Item Leadtime        :' ITEM-LEADTIME.
           display 'Item Balance on Hand :' ITEM-STOCK.
           

       bom-reader Section.
           read Bill-o-Mat
               at end set bom-eof-flag to 1 *> notice the SET statement
           end-read.         
   
       bom-reader-writer Section.
       010-begin.
           perform bom-reader.
           add 1 to bom-row-counter.
           display 'BOM RECORD COUNT ' 
           bom-row-counter '#################'.
           display 'BOM Final Product :' BOM-TOPLVL-ITEM-CODE.
           display 'BOM Component     :' BOM-COMPLVL-ITEM-CODE.
           display 'BOM Ratio         :' BOM-RATIO.



*          goback.
