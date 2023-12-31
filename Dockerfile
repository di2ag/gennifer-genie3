FROM python:3.8

RUN apt-get update && apt-get install -y time python3-pip
RUN apt-get install time

# add app user
RUN groupadd gennifer_user && useradd -ms /bin/bash -g gennifer_user gennifer_user

# Set the working directory to /app
WORKDIR /app

COPY ./requirements.txt /app

# Install the required packages
RUN pip3 install --no-cache-dir -r requirements.txt

# chown all the files to the app user
RUN chown -R gennifer_user:gennifer_user /app

USER gennifer_user

COPY runArboreto.py /app
RUN mkdir data/

# Copy the current directory contents into the container at /app
COPY . /app

# Start the Flask app
CMD ["flask", "--app", "genie3", "run", "--host", "0.0.0.0", "--debug"]


#RUN conda install -y -c bioconda/label/cf201901 arboreto=0.1.5 pandas=0.24.0
