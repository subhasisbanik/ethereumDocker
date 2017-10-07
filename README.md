This project can be used for using a single Ethereum node in Docker which runs in a private network.
The steps below will take to through the setup of single node to web3 deploy.

1. Clone the project into your machine:

2. Make the Docker image:
cd ethereumDocker<br>
docker build -t {image-name} .<br>

3. Run the Docker image as a container:
docker run -d -i -p {docker-rpc-port}:{host-rpc-port} {image-name}<br>

4. Now enter the container:
docker exec -it <container-id/container-name> /bin/bash<br>

5. Make a folder in /root for the geth data to be stored:
cd /root<br>
mkdir testnet<br>
cd testnet<br>
mkdir datadir<br>
cd datadir<br>
mkdir keystore<br>
cd ~<br>

6. Now make a new geth account with any password or empty and correspondingly update the password.txt that will be made:
geth --datadir "/root/testnet/datadir" account new<br>
cd testnet <br>
touch password.txt<br>
cd ~<br>


 Note down the account number as you will need it in the next step.


7. Now run puppeth to prepare the genesis.json for your private chain setup:

    cd testnet<br>
    puppeth<br>

    Please follow the steps by selecting the options in the interactive shell:

    a. 2. Configure new genesis<br>

    b. 1. Ethash - proof-of-work<br>

    c. Which accounts should be pre-funded? (advisable at least one)
    0x{account-number}<br>

    d. Specify your chain/network ID if you want an explicit one (default = random)<br>
    {Enter any value}

    e. Anything fun to embed into the genesis block? (max 32 bytes)<br>
    {Skip with enter}

    f. 2. Save existing genesis<br>

    Now after this you will have your genesis.json file to initialize geth

8. Now we need to initialize geth:
    geth --datadir "/root/testnet/datadir" init genesis.json<br>

9. Now we need to run geth as a background process:
    nohup geth --datadir "/root/testnet/datadir" --networkid {previously-entered-networkid-puppeth} --port <portid> --identity {any-identifiable-name} --verbosity 3 --rpc --rpcapi "eth,web3,net,admin,miner,personal" --rpcport {rpc-port-docker} --rpcaddr "0.0.0.0" --rpccorsdomain * --mine --minerthreads 2 --unlock 0 --password "/root/testnet/password.txt" console &<br>

    Here we need to replace the values with '{}' with valid data.

10. Now enter the geth console with rpc:<br>
    geth attach rpc:http://127.0.0.1:8545<br>

11. Go to https://remix.ethereum.org and copy the below code to generate a sample web3 deploy:<br>

    pragma solidity ^0.4.0;
    contract test {

        uint _val;
        function getValue() returns(uint){
            return _val;
        }
        function setValue(uint val){
            _val=val;
        }
    }



12. Copy the web3 deploy and paste it in the geth console and wait for it to be mined.

Congratulations, you have succssfully set up a private chain Ethereum.

For more details in Ethereum,
http://www.ethdocs.org/en/latest/ethereum-clients/cpp-ethereum/index.html#quick-start
