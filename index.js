const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

app.post('/api/getlink', (req, res) => {
  const videoUrl = req.body.youtube_url;
  if (!videoUrl) {
    return res.status(400).json({ error: 'youtube_url is required' });
  }

  exec(`yt-dlp -f best -g "${videoUrl}"`, (error, stdout, stderr) => {
    if (error) {
      return res.status(500).json({ error: 'Failed to fetch video link', details: stderr });
    }
    const downloadUrl = stdout.trim();
    res.json({ download_url: downloadUrl });
  });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});