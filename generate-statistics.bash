#!/bin/bash
set -x
INDEX=statistics.markdown

# build index page
echo "---" > $INDEX
echo "layout: page" >> $INDEX
echo "title: Statistics" >> $INDEX
echo "---" >> $INDEX
echo >> $INDEX
echo "# Statistics" >> $INDEX
echo >> $INDEX
echo "_These are semi-automatically generated statistics from apertium-fin-deu
database._ The statistics are based on the actual data in the XML files
and the versions of whole analysed corpora and tools on this date." >> $INDEX
echo >> $INDEX
echo "Generation time was \`$(date --iso=hours)\`" >> $INDEX
head -n 8 config.log | tail -n 6 >> $INDEX
echo "## Bilingual dictionary" >> $INDEX
echo >> $INDEX
echo "The numbers are counted from the database, unique lexical items." >> $INDEX
echo >> $INDEX

echo "### Per primary apertium tags" >> $INDEX
echo >> $INDEX
echo "These approximations are based rough grepping of the XML file and
have number of inconsistencies and mistakes. The more accurate XPATH/XSLT
counting is WIP" >> $INDEX
echo >> $INDEX
echo "| Frequency | l>s@n |" >> $INDEX
echo "|----------:|:-----|" >> $INDEX
fgrep '<l' < apertium-fin-deu.fin-deu.dix |\
    sed -e 's/></\t/g' | tr -s '</>' '\t' | cut -f 6 | fgrep 's n='|\
    sed -e 's/s n="//' -e 's/"//' | sort | uniq -c | sort -nr |\
    sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]$//' |\
    sed -e 's/ / | /' -e 's/^/| /' -e 's/$/ |/' >> $INDEX
echo >> $INDEX
echo "| Frequency | r>s@n |" >> $INDEX
echo "|----------:|:-----|" >> $INDEX
fgrep '<r' < apertium-fin-deu.fin-deu.dix |\
    sed -e 's/></\t/g' | tr -s '</>' '\t' | cut -f 10 | fgrep 's n='|\
    sed -e 's/s n="//' -e 's/"//' | sort | uniq -c | sort -nr |\
    sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]$//' |\
    sed -e 's/ / | /' -e 's/^/| /' -e 's/$/ |/' >> $INDEX
echo >> $INDEX
echo The lexemes in the following table are identical in both languages
echo "| Frequency | i>s@n |" >> $INDEX
echo "|----------:|:-----|" >> $INDEX
fgrep '<i' < apertium-fin-deu.fin-deu.dix |\
    sed -e 's/></\t/g' | tr -s '</>' '\t' | cut -f 5 | fgrep 's n='|\
    sed -e 's/s n="//' -e 's/"//' | sort | uniq -c | sort -nr |\
    sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]$//' |\
    sed -e 's/ / | /' -e 's/^/| /' -e 's/$/ |/' >> $INDEX
echo >> $INDEX

echo "## Rulesets" >> $INDEX
echo >> $INDEX
echo "Rulesets in apertium translation govern chunking, re-ordering,
lexical selections etc." >> $INDEX
echo >> $INDEX

function count_tnx() {
echo
echo "| Frequency | type |"
echo "|----------:|:-----|"
egrep '<(def-|rule)' < apertium-fin-deu.$1.$2 |\
    cut -f 1 | sed -e 's/^[[:space:]]*//' | cut -d ' ' -f 1 | tr -d '<' |\
    sort | uniq -c | sort -nr |\
    sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]$//' |\
    sed -e 's/ / | /' -e 's/^/| /' -e 's/$/ |/'
echo
}

echo "### German to Finnish" >> $INDEX
echo >> $INDEX
echo "German-to-Finnish lexical selection" >> $INDEX
count_tnx deu-fin lrx >> $INDEX
echo >> $INDEX
echo "German chunking (deu-fin.t1x)" >> $INDEX
count_tnx deu-fin t1x >> $INDEX
echo "German to Finnish reordering (deu-fin.t2x)" >> $INDEX
count_tnx deu-fin t2x >> $INDEX
echo "??? (deu-fin.t3x)" >> $INDEX
count_tnx deu-fin t3x >> $INDEX
echo "### Finnish to German" >> $INDEX
echo >> $INDEX
echo "Finnish-to-German lexical selection" >> $INDEX
count_tnx fin-deu lrx >> $INDEX
echo >> $INDEX
echo "Finnish chunking (fin-deu.t1x)" >> $INDEX
count_tnx fin-deu t1x >> $INDEX
echo "Finnish to German reordering (fin-deu.t2x)" >> $INDEX
count_tnx fin-deu t2x >> $INDEX
echo "??? (fin-deu.t3x)" >> $INDEX
count_tnx fin-deu t3x >> $INDEX

echo "## Binaries" >> $INDEX
echo >> $INDEX
echo "just a rough idea of memory requirements and packaging" >> $INDEX
echo >> $INDEX
ls -lh *.bin *.hfst | awk '{printf("| %s | %s |\n", $9, $5);}' >> $INDEX

