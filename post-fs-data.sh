MODDIR=${0%/*}
TMPDIR="/dev/anyfs"
PATH="/system/bin:$PATH"

mkdir -p $TMPDIR
mount -t tmpfs anyfs -o remount $TMPDIR

for i in `ls $MODDIR/anymount`; do
    [ -d $TMPDIR/upper/$i ] && flag="remount,"
    mkdir -p $TMPDIR/upper/$i $TMPDIR/work/$i
    cp -a $MODDIR/anymount/$i/* $TMPDIR/upper/$i

    mount -t overlay anyfs -o "$flag"lowerdir=/$i,upperdir=$TMPDIR/upper/$i,workdir=$TMPDIR/work/$i /$i
    restorecon -R /$i
done
