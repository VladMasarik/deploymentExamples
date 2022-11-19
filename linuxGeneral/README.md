
## Zip / Tar / Compress
`-k` because the file is deleted by default, this will keep it
`-d` decompress
```
gzip -k myfile.txt
gzip -k -d myfile.gz
```

## Networking
Which process occupies what port. Without `sudo` it wont say the process name
```
sudo netstat -antp
```


## SSH / SSH copy SCP
```
ssh -i ~/.ssh/machine vmadmin@20.163.251.228
scp -i ~/.ssh/machine <source> <destination>
```
Both source and destination have the same format based on what you want to do.
From local to remote, and reverted if you want from remote to local
```
~/.ssh/machine azureuser@<IP>:/home/azureuser/.ssh/
scp -i ~/.ssh/machine ~/.ssh/machine vmadmin@20.163.251.228:/home/azureuser/.ssh/
```

## File permissions / owner
Change permissions of everything recursively 
```
sudo chown vmadmin:vmadmin -R beelivingsensor-postgis-ygug/
```

## Working with disks / mounting them
List all devices even the not mounted ones
```
lsblk
```
Mount device into a folder
```
sudo mount /dev/sda postgresdb/
```