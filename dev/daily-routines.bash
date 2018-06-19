#!/bin/bash
DAILYMAIL_SOURCE=texts/dw.de-Langsam-gesprochene-Nachrichten-$(date --iso).text
if ! test -f ${DAILYMAIL} ; then
    echo ${DAILYMAIL} ist nicht da, bitte herunterladen
    exit 1
fi
DAILYMAIL=$(mktemp -t apertium-fin-deu-dailies.XXXXXXXXXX )
make
egrep -v '^#!' ${DAILYMAIL_SOURCE} > ${DAILYMAIL}
if ! apertium -f line -d . deu-fin-debug < ${DAILYMAIL} |\
    fgrep --colour=always '@' ; then
    if ! apertium -f line -d . deu-fin-debug < ${DAILYMAIL} |\
        fgrep --colour=always '#' ; then
        apertium -f line -d . deu-fin < ${DAILYMAIL}
        echo
        echo "Translation is testvoc clean, commit?"
        select a in yes no ; do
            if test x$a = xyes ; then
                git add apertium-fin-deu.fin-deu.dix ${DAILYMAIL_SOURCE}
                git commit -m "daily news $(date --iso)"
            elif test x$a = xno ; then
                echo commit cancelled
            else
                echo Unknown answer $a
            fi
            break
        done
    else
        echo bidix miss candidates in apertium-fin:
        apertium -f line -d . deu-fin-debug < ${DAILYMAIL} |\
            egrep -o '#[^<]*' |\
            tr -d '#<' |\
            sort |\
            uniq |\
            hfst-lookup -q fin-deu.automorf.hfst |\
            fgrep '<'
    fi
else
    apertium -f line -d . deu-fin-debug < ${DAILYMAIL} |\
        egrep -o '@[^<]*' |\
        tr -d '@<' |\
        sort |\
        uniq |\
        lt-proc -a deu-fin.automorf-untrimmed.bin |\
        tr -d '^$' |\
        tr '/' '	' |\
        sed -e 's/></./g' |\
        fgrep '<' --colour=always
fi
rm -v ${DAILYMAIL}
