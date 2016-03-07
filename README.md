# Docker image dedicated to functional tests @ FeetMe

Including:
- Python
- Ruby
- NodeJs
- Jenkins
- Selenium & Lettuce (Python)

## Build
sudo docker build -t jenkins_full_feetme .

## Run
sudo docker run -p 8080:8080 -v /var/lib/jenkins:/var/lib/jenkins -ti jenkins_full_feetme bash
