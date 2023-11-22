const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  // Assuming your index.html is in the same directory as app.js
  const filePath = path.join(__dirname, 'index.html');

  // Read the HTML file
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      console.error('Error reading the file:', err);
      res.writeHead(500, { 'Content-Type': 'text/plain' });
      res.end('Internal Server Error');
    } else {
      // Set the content type to HTML
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(data);
    }
  });
});

const port = 3000;
server.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
