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
           Select Store-Data assign to "input.txt"
                  Organization is line sequential.
           select output-file assign to "outfile.txt"
                  Organization is line sequential.
      
       configuration section.

       data division.
       File Section.
       FD Store-Data.
      
       01 Store-Rec.
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
           05 filler       pic x(21) value spaces
       
       01 header-2.
           05 filler       pic x(13) value spaces.
           05 filler       pic x(5) value 'FIELD'.
           05 filler       pic x(6) Value spaces.
           05 filler       pic x(4) value 'DATA'.
           05 filler       pic x(7) value spaces.
           05 filler       pic x(5) value 'ERROR'
           
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
           05 filler       pic x(12)value 'BAD RECORDS:'.
           05 bad-rec-out  pic zz9 value '0'.
          


       procedure division.

           goback.

       end program Program1.