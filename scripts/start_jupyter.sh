# Note: make sure host folders have a+rwx access (i.e., chmod a+rwx *) 
# Also, make sure that docker is installed (wget -qO- https://get.docker.com/ | sh)

docker rm jupyter
docker run --privileged=true -d -p 8888:8888 --name jupyter \
	--user root \
        -v /mnt/:/mnt \
	-v /root/mshahbaz/notebooks/:/home/jovyan/work/ \
	-v /root/mshahbaz/keys/notebooks.pem:/etc/ssl/notebooks.pem \
	-e GRANT_SUDO=yes \
	jupyter/r-notebook start-notebook.sh \
			--NotebookApp.password='sha1:090e0e9b7507:b5d41f836d73c79fc4402f514a8cba63efc2fe3d' \
			--NotebookApp.certfile=/etc/ssl/notebooks.pem
docker exec jupyter apt-get update
docker exec jupyter pip install --upgrade pip
docker exec jupyter pip install pandas matplotlib seaborn statsmodels joblib bitstring
docker exec jupyter Rscript /home/jovyan/work/baseerat/scripts/install_packages.r
docker exec jupyter apt-get -y install libreadline-dev
docker exec jupyter pip install rpy2
