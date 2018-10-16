#!/bin/bash

# command line stream
STREAM=$1

# pre filled streams
declare -A STREAMS
STREAMS[Radio2000]="rtmp://cdn-radio-za-colony-sabc.antfarm.co.za:80/sabc-radio2000/r2000_s.stream_64k"
STREAMS[New Zealand Sport]="http://streaming.radiomyway.co.nz/rsportalt.pls"
STREAMS[Australia ABC Cricket]="http://live-radio01.mediahubaustralia.com/GSDW/mp3/;stream.nsv#.mp3"
STREAMS[Classical MPR]="http://cms.stream.publicradio.org/cms.mp3"
STREAMS[Antenne Niedersachsen 80er]="http://stream.antenne.com/antenne-nds-80er/mp3-64/listenlive/play.m3u"
STREAMS[Antenne Niedersachsen 90er]="http://stream.antenne.com/antenne-nds-90er/mp3-64/listenlive/play.m3u"
STREAMS[none]="quit"

# if argument STREAM is not empty
if [[ ! -z "${STREAM// }" ]]; then
    # play stream
    mplayer -cache 2048 -cache-min 20 $STREAM

# if STREAM is empty, select from a list of pre-configured streams
else
    # provide menu of streams
    select KEY in "${!STREAMS[@]}"; do

        # exit
        case $KEY in
            "none")
                echo "Exiting"
                break
            ;;

        # process selected stream
        *)
            echo "stream $KEY selected, streaming ${STREAMS[$KEY]} ..."
            if [[ "${STREAMS[$KEY]}" == *m3u ]] || [[ "${STREAMS[$KEY]}" == *pls ]]; then
                mplayer -cache 2048 -cache-min 20 -playlist ${STREAMS[$KEY]}
            else
                mplayer -cache 2048 -cache-min 20 ${STREAMS[$KEY]}
            fi
            ;;
        esac
    done
fi
exit 0
