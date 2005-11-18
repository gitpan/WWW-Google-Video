use inc::Module::Install;

name            ('WWW-Google-Video');
abstract        ('1');
author          ('Lilo Huang <kenwu@mail.tnssh.tn.edu.tw>');
license         ('perl');
version_from    ('lib/WWW/Google/Video.pm');
requires        ('LWP::Simple');
build_requires  ('Test::More');

&WriteAll;

