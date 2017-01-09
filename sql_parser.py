# -*- coding: utf8 -*-
import re


class Table(object):
    def __init__(self, name):
        self.name = name
        self.fields = []

    def __repr__(self):
        msg = '<Table(%s): Fields:%s>' % (self.name, self.fields)
        return msg


def read_sql_file():
    with open('settle.sql') as fin:
        for line in fin:
            yield line.strip()


def parse(stream):
    table_pattern = re.compile(r'^CREATE TABLE `(\w+)`')
    field_pattern = re.compile(r"^`([_a-z]+)` (\w+).*COMMENT\s+'(.*)'")

    while True:
        try:
            line = next(stream)
        except StopIteration:
            break

        if line.startswith('CREATE'):
            m = re.search(table_pattern, line)
            table_name = m.groups()[0]

            t = Table(table_name)

            while line is not None and not line.startswith(')'):
                line = next(stream)
                if not line:
                    continue
                m = re.search(field_pattern, line)
                if m:
                    t.fields.append(m.groups())

            yield t


def sql2class(name):
    """ xx_yy --> XxYy """
    return ''.join(x.capitalize() for x in name.split('_'))


def dump(t):
    excluded_fields = {'id', 'created_at', 'updated_at'}
    print 'class %sConverter(object):' % sql2class(t.name)

    # __init__()
    print '    def __init__(self, context):'
    print '        self.context = context'
    print

    # fields
    for name, t, comment in t.fields:
        if name in excluded_fields:
            continue

        print '    @property'
        print '    def %s(self):' % (name, )
        print '        """#%s -- %s"""' % (t, comment)
        print '        pass'
        print


MigrateTables = {
    # data-sync
    'voucher', 'voucher_extra', 'biz_voucher',
    # settle
    'settle_detail', 'settle_merchant_detail',
    'settle_deliver_detail',
    # clearing
    'settle_clearing_charge_entry', 'settle_clearing_payable',
    'settle_clearing_pay_plan'
}


def main():
    stream = read_sql_file()
    for t in parse(stream):
        if t.name in MigrateTables:
            dump(t)
            print


if __name__ == '__main__':
    main()
