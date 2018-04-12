       identification division.
       program-id. Store-Data-Validation.
      *****************************************************************
      * This program will validate the data from our file listing all *
      * of the store's Territory Number, Area Number and Depatrment   *
      * numbers                                                       *
      ***************************************************************** 
       environment division.
       Input-output Section.
       file-control.
           Select store-data assign to "input.txt"
                  Organization is line sequential.
           select output-file assign to "outfile.txt"
                  Organization is line sequential.
      
       configuration section.

       data division.
       File Section.
       FD Store-Data.
      
       01 store-rec.
           05 terr-num-in  pic x(2).
           05 area-num-in  pic x(2).
           05 dept-num-in  pic x(2).
      
       FD output-file.
       01 report-rec   pic x(53).

       working-storage section.
       01 eof  pic x value "n".
       
       01 blank-line   pic x(53) value spaces.
       
       01 header-1.
           05 filler       pic x(20) value spaces.
           05 filler       pic x(12) value 'ERROR REPORT'.
           05 filler       pic x(21) value spaces.
       
       01 header-2.
           05 filler       pic x(13) value spaces.
           05 filler       pic x(5) value 'FIELD'.
           05 filler       pic x(6) Value spaces.
           05 filler       pic x(4) value 'DATA'.
           05 filler       pic x(7) value spaces.
           05 filler       pic x(5) value 'ERROR'.
           
       01 detail-line.
           05 filler       pic x(10) value spaces.
           05 field-out    pic x(10).
           05 data-out     pic x(2).
           05 filler       pic x(5) value spaces.
           05 err-msg-out  pic x(12).
           
       01 summary-line-1.
           05 filler       pic x(10) value spaces.
           05 filler       pic x(13) value 'GOOD RECORDS:'.
           05 good-rec-out pic zz9 value '0'. 
           05 filler       pic x(26) value spaces.
       01 summary-line-2.
           05 filler       pic x(11) value spaces.
           05 filler       pic x(12) value 'BAD RECORDS:'.
           05 bad-rec-out  pic zz9 value '0'.
       
       01 ws-good-rec-ctr  pic 999.
       
       01 ws-bad-rec-ctr   pic 999.
       
       01 ws-good-rec-flag pic x(1).
       
       procedure division.
       
       100-main.
               open input store-data
                   output output-file.
                
          perform 300-header
           
          perform until eof = 'y'
            read store-data
            at end move 'y' to eof
            not at end perform 200-validate
          
             perform 400-footer
         
           end-read
           end-perform.
           close store-data, output-file.
          stop run.
          
       200-validate.
           move 'y' to ws-good-rec-flag
           if terr-num-in not numeric 
               move 'TERRITORY' to field-out
               move terr-num-in to data-out
               move 'NOT NUMERIC' to err-msg-out
               write report-rec from detail-line
               move 'n' to ws-good-rec-flag.
          
               
           if terr-num-in not = '1' and '2' and '3'
               move 'TERRITORY' to field-out
               move terr-num-in to data-out
               move 'OUT OF RANGE' to err-msg-out
               write report-rec from detail-line
               move 'n' to ws-good-rec-flag.
         
           
           if area-num-in is not numeric 
               move 'AREA' to field-out
               move area-num-in to data-out
               move 'NOT NUMERIC' to err-msg-out
               write report-rec from detail-line
               move 'n' to ws-good-rec-flag.
      
           
           if area-num-in not = '1' and '2' and '3' 
               move 'AREA' to field-out
               move area-num-in to data-out
               move 'OUT OF RANGE' to err-msg-out
               write report-rec from detail-line
               move 'n' to ws-good-rec-flag.
        
           
           if dept-num-in is not numeric 
               move 'DEPARTMENT' to field-out
               move dept-num-in to data-out
               move 'NOT NUMERIC' to err-msg-out
               write report-rec from detail-line
               move 'n' to ws-good-rec-flag.
          
           
           if dept-num-in not = '1' and '2' and '3' and '4' and '5'  
      -    and '6' and '7' and '8' and '9' and '10'
               move 'DEPARTMENT' to field-out
               move dept-num-in to data-out
               move 'OUT OF RANGE' to err-msg-out
               write report-rec from detail-line
               move 'n' to ws-good-rec-flag.
           
           
           if ws-good-rec-flag = 'y'
              add 1 to ws-good-rec-ctr
           else
               add 1 to ws-bad-rec-ctr.
           
           
       300-header.
           write report-rec from header-1
           write report-rec from blank-line
           write report-rec from header-2.
       
       400-footer.
           write report-rec from blank-line
           write report-rec from summary-line-1
           write report-rec from summary-line-2.
       
       
     
       
