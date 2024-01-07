MODDIR=${0%/*}
TMPDIR="/dev/anyfs"
PATH="/system/bin:$PATH"

if [ -z "`mkdir $TMPDIR 2>&1`" ]; then
     mount -t tmpfs anyfs $TMPDIR
     mkdir  $TMPDIR/upper $TMPDIR/work
fi

for i in "`ls $MODDIR/anymount`"; do
    if [ -z "`mkdir $TMPDIR/work/$i 2>&1`" ]; then
        cp -r $MODDIR/anymount/$i $TMPDIR/upper/$i
        mount -t overlay anyfs -o lowerdir=/$i,upperdir=$TMPDIR/upper/$i,workdir=$TMPDIR/work/$i /$i
        restorecon -R /$i
    fi
done
