# Use a Node.js image as the base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json first to install dependencies
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Install PM2 globally (this is the same as your Jenkins script)
RUN npm install pm2 --save-dev

# Expose the port your application will run on (e.g., 3000)
EXPOSE 3000

# Command to run your application
CMD ["npx", "pm2", "start", "index.js", "--name", "skillupnodejs"]

# Optional: If you need to allow PM2 logs to be available for debugging
CMD ["npx", "pm2", "start", "index.js", "--name", "skillupnodejs", "&&", "tail", "-f", "logs/*.log"]
