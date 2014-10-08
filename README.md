# Provisioning API

## Imstall

Create a fog credentials file in `~/.fog`:

``` yaml
default:
  aws_access_key_id: some_value
  aws_secret_access_key: some_value
  public_key_path: '~/.ssh/ninja.pub'
  private_key_path: '~/.ssh/ninja'  
```

Install gems:

```
$ gem install bundler
$ bundle install
```

## Run

```
ruby server.rb
```

## Creating Instances

POST http://localhost:5555/compute
Content-Type: application/json

``` json
{
  "compute": [
    {
      "provider": "aws",
      "region": "eu-west-1",
      "image_id": "ami-7aa8080d",
      "flavor_id": "m3.medium",
      "username": "ubuntu"
    },
    {
      "provider": "google",
      "zone_name": "europe-west1-a",
      "image_name": "debian-7-wheezy-v20140926",
      "machine_type": "n1-standard-1",
      "username": "ubuntu"
    }
  ]
}
```

## Useful Links

- http://cloud-images.ubuntu.com/locator/ec2/
- https://github.com/fog/fog/blob/master/lib/fog/aws/compute.rb

## Legacy Install

Install jruby 1.7.16.  Ask it to set the paths

Set the GEM_HOME environment variable, e.g.:

```
set JRUBY_HOME=C:\jruby-1.7.16
```

Run:
```
c:\jruby-1.7.16\bin\bundle install
```


