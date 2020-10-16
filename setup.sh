PATH_=$HOME/.transferpi

echo "---------------------------------"
echo "|     Installing Transfer Pi    |"
echo "---------------------------------"
if [[ -d $PATH_ ]]
then
    echo "* Removing Previous Installation "
    rm -rf $PATH_/bin
    rm -rf $PATH_/logs
    rm -rf $PATH_/data/templates
else 
    mkdir PATH_
fi

mkdir -p $PATH_/bin
mkdir -p $PATH_/logs
mkdir -p $PATH_/data
mkdir -p $PATH_/data/templates

touch $PATH_/logs/tunnel_logs.txt
touch $PATH_/logs/server_logs.txt

cp bin/* $PATH_/bin/ -r
cp data/* $PATH_/data/ -r

cd $PATH_/bin
mv add tpi-add
mv get tpi-get
mv list tpi-list
mv remove tpi-remove
mv fileserver tpi-fileserver
mv tunnel tpi-tunnel

echo "* Appending Path"

if [[  "$PATH" == *"$PATH_"*  ]]
then
    echo "   |_ Path Already There, Skipping"
else
    echo "export PATH=\$PATH:\$HOME/.transferpi/bin" >> $HOME/.bashrc
fi

echo "* Transfer Pi Installed Successfully"
echo "* Now go to https://transferpi.tk/login"
echo "* Login using your google account"
echo "* Retrive config.json"
echo "* Place it under $HOME/.transferpi/"