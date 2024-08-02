# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install make and other dependencies
RUN apt-get update && \
    apt-get install -y make && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt using make
RUN make install

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run app when the container launches
CMD ["make", "run"]
