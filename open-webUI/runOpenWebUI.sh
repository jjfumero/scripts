## Pull new version of open-webui docker image and launch it 
docker stop open-webui 
docker rm -f open-webui 
docker pull ghcr.io/open-webui/open-webui:cuda 

## Access in localhost:8080 
docker run -d --network=host --gpus all -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:cuda
