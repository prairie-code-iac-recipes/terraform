# Terraform Docker Container
---
## Why
So why create yet another Terraform Docker image?  Because some of the packages I need to install are not available on Alpine, and it looks like Hashicorp is only building Alpine images. I could have tried to find someone else's Debian-based Terraform image, but if you look around on Docker Hub you'll see that many of the unofficial images aren't maintained very well.  Lastly, since I have some additional needs, I can create a somewhat more opinionated image and forego installing packages as part of my CI/CD pipeline.

## Usage

If you have Docker installed, you can use this image to run Terraform commands without installing Terraform directly on your computer.

For example, the following is using this image to run Terraform "plan" against the current directory:

```bash
# docker run -it salte-io/terraform:12.7 plan
```

If you want to shell into this image, to do some playing around, you can do so by running the following command:

```bash
# docker run -it --rm --entrypoint="" salte-io/terraform:12.7 sh
```

Last, but not least, you can use this image inside of your CI/CD pipeline:

### Bitbucket Cloud
```YAML
pipelines:
  default:
    - step:
        name: Validate Terraform Files
        image: salte/terraform:12.7
        script:
          - terraform init
          - terraform validate
```
### Gitlab
```YAML
validate:
  stage: validate
  image:
    name: salte/terraform:12.7
    entrypoint: [""]
  script:
    - terraform init
    - terraform validate
```
