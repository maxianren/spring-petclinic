pipeline { 
agent any  
stages { 
stage('Prepare') { 
steps { 
script { 
sh """ 
whoami 
ls -la /var/run/docker.sock 
docker ps 
docker images 
""" 
} 
} 
}  
}  
}