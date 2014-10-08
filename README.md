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

## Run

```
ruby server.rb
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
