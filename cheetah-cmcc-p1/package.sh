cd $PACKAGE

chip=sun50iw2p1
platform=android
if [ "$TARGET_PRODUCT" = "cheetah_aosp_perf" ];then
	board=perf1_v1_0
else
    board=cheetah-cmcc-p1
fi
debug=uart0
sigmode=none
kernel_ver=linux-3.10
function=none
sigmode=none
mode=normal
no_img=none
programmer=none

usage()
{
	printf "Usage: pack [-cCHIP] [-pPLATFORM] [-bBOARD] [-d] [-s] [-h]
	-c CHIP (default: $chip)
	-p PLATFORM (default: $platform)
	-b BOARD (default: $board)
	-d pack firmware with debug info output to card0
	-s pack firmware with signature
	-h print this help message
    -m normal or ota boot test
"
}
while getopts "c:p:b:dsfhmnw" arg
do
	case $arg in
		c)
			chip=$OPTARG
			;;
		p)
			platform=$OPTARG
			;;
		b)
			board=$OPTARG
			;;
		d)
			debug=card0
			;;
		s)
			sigmode=secure
			;;
		f)
			function=prev_refurbish
			;;
		h)
			usage
			exit 0
			;;
        m)
            mode=ota_test
            ;;
        n)
            no_img="no_img"
            ;;
        w)
            programmer="programmer"
            ;;

		?)
			exit 1
			;;
	esac
done

./pack -c $chip -p $platform -b $board -d $debug -s $sigmode -k ${kernel_ver} -f ${function} -m ${mode} -n ${no_img} -w ${programmer}
