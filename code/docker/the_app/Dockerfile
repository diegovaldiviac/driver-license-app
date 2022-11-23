# we are starting to build our docker container based on the 
# python:3.9-alpine image.
FROM python:3.9-alpine

# make a folder inside the container named /usr/src/app
RUN mkdir /usr/src/app/

# set the new folder we just created as the working directory
WORKDIR /usr/src/app/

# copy everything from the current folder (the one where this 
# Dockerfile lives) into the folder we created above. 
COPY . /usr/src/app/

# make port 4000 of the container available to the host machine
# port 4000 is the default port that a Flask app listens on. 
EXPOSE 4000

# use pip (the python package manager) to install in the container 
# whatever packages are listed in the requirements.txt file 
RUN pip install -r requirements.txt

# execute the file app.py 
CMD ["python", "app.py"]