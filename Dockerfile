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

# Install PM2 globally
RUN npm install pm2 --save-dev

# Expose the port your application will run on (e.g., 3000)
EXPOSE 9595

# Use a shell to run multiple commands in the CMD
CMD ["sh", "-c", "npx pm2 start index.js --name 'skillupnodejs' && tail -f /root/.pm2/logs/*.log"]
