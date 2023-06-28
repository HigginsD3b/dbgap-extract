#set variables
study_page="https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id="
download_page="https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/GetAuthorizedRequestDownload.cgi?study_id="
txt=".txt"

#download the files
while read PHS; do
    full_PHS=$(wget $study_page$PHS 2>&1 | grep Location: | cut -d '=' -f 2 | cut -d ' ' -f 1)
    wget -O $full_PHS$txt $download_page$full_PHS 
    rm study.cgi?study_id=$PHS
    done <phs.txt  

#make headerless files
for file in phs0*; do
    tail -n+2 $file > nohead.$file
    done

#combine files
cat header.txt nohead.* > final.txt

#cleanup
rm nohead.*
