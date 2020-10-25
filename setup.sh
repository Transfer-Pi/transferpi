PATH_=$HOME/.transferpi

create_service(){
    UNIT=./$1.service
    echo "[Unit]" >> $UNIT;
    echo "Description=Transfer Pi : $2" >> $UNIT;
    echo "After=multi-user.target" >> $UNIT;
    echo "" >> $UNIT; 
    echo "[Service]" >> $UNIT;
    echo "Type=simple" >> $UNIT;
    echo "ExecStart=$HOME/.transferpi/bin/$1" >> $UNIT;
    echo "" >> $UNIT;
    echo "[Install]" >> $UNIT;
    echo "WantedBy=multi-user.target" >> $UNIT;
    sudo mv $UNIT /lib/systemd/system/

    echo "   |_ Service Created For $2"
}

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
    mkdir $PATH_
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
mv manage tpi-manage

echo "* Appending Path"
if [[  "$PATH" == *"$PATH_"*  ]]
then
    echo "   |_ Path Already There, Skipping"
else
    echo "export PATH=\$PATH:\$HOME/.transferpi/bin" >> $HOME/.bashrc
fi

export PATH=$PATH:$HOME/.transferpi/bin

echo "* Creating Services"
create_service "tpi-fileserver" "Fileserver"
create_service "tpi-tunnel" "Tunnel"

echo "* Transfer Pi Installed Successfully"

