import yaml
import sys
import os
import re


TEMPLATE='docker-compose-template.yml'
SECRETS='~/.xgsenv'

def write_config(template, filename):
    f = open(filename, 'w')
    yaml.dump(template, f, default_flow_style=False)
    f.close()

def get_image(app):
    if bool(re.match('apps/\w+', app)):
        return 'tutum.co/govuk/xgs_%s' % app.split('/')[1]


def main():
    print('Generate config')
    which = raw_input('1: dev\n2: aws\n\n')
    if which == '1':
        which = 'dev'
    elif which == '2':
        which = 'aws' 
    else:
        print('Bad option. Exiting...')
        sys.exit()

    with open(TEMPLATE) as template:
       template_yaml = template.read()
    with open(os.path.expanduser(SECRETS)) as secrets:
        secrets_yaml = secrets.read()
    secrets = yaml.load(secrets_yaml)

    # replace secrets
    for k,v in secrets.iteritems():
        key = '__%s__' % k
        template_yaml = template_yaml.replace(key, str(v))

    template = yaml.load(template_yaml)

    if which == 'dev':
        write_config(template, 'docker-compose.yml')
    elif which == 'aws':
        del template['maslow']
        del template['postgres']
        # replace 'build' with 'image'
        for app, nested in template.iteritems():
            for key, val in nested.iteritems():
                if key == 'build':
                    del nested[key]
                    nested['image'] = get_image(val)
                    template[app] = nested
                    break
            else:
                continue

        # remove 'volumes'
        for app, nested in template.iteritems():
            for key, val in nested.iteritems():
                if key == 'volumes':
                    del nested[key]
                    template[app] = nested
                    break
            else:
                continue

        write_config(template, 'aws.yml')


if __name__ == '__main__':
    main()
