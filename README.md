# Docker image dedicated to functional tests @ FeetMe

Including:
- Python
- Ruby
- NodeJs
- Jenkins
- Selenium & Lettuce (Python)
- Android SDK
- Java 8
- AWS CLI

## Build
sudo docker build -t jenkins_full_feetme .

## Run
sudo docker run --privileged --net=host -p 8080:8080 -v /var/lib/jenkins:/var/lib/jenkins -ti jenkins_full_feetme bash
