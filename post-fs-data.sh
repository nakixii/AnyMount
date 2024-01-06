PATH="/system/bin:$PATH"
MODDIR=${0%/*}

mkdir -p /dev/anyfs
mount -t tmpfs anyfs /dev/anyfs
mkdir -p /dev/anyfs/work

for i in `ls $MODDIR/anymount`; do
    cp -r $MODDIR/anymount/$i /dev/anyfs
    mkdir -p /dev/anyfs/work/$i
    mount -t overlay anyfs -o lowerdir=/$i,upperdir=/dev/anyfs/$i,workdir=/dev/anyfs/work/$i /$i
    restorecon -R /$i
done
