# Video Player App

A Flutter app that fetches video data from an API, displaying it on the homepage with thumbnails, channel descriptions, titles, total views, and creation dates. The app features a video player screen using FijkPlayer to play HLS videos.

## Screenshots

### Homepage
<img src="/home.png" alt="Screenshot 1" width="150"/>


### Video Player Screen

<img src="/video.png" alt="Screenshot 1" width="150"/>
<img src="/videoplayer.png" alt="Screenshot 1" width="150"/>

## Overview

This project is built on an API that provides video data. The homepage showcases all available videos, presenting details such as video thumbnails, channel description images, titles, total views, and creation dates, all sourced from the API.

Clicking on a video thumbnail on the homepage navigates the user to the Video Player screen. Here, videos are played using the FijkPlayer, which supports HLS video types. The video automatically starts playing when the thumbnail is hidden.

## Features

- Homepage displaying videos with details from the API.
- Video Player screen utilizing FijkPlayer for playing HLS videos.
- Display total views and upload duration on the Video Player screen.
- GetX state management employed, with a HomeController to fetch data from the API.
- The Bangla font "Mina" from Google Fonts is used for text styling.

## Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/your-repo.git
