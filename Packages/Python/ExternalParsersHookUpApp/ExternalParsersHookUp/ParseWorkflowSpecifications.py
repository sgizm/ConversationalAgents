from .RakuCommandFunctions import RakuCommand


def ToDataQueryWorkflowCode(command, execute=True, target='Python-pandas', globals=globals()):
    if target in ['pandas']:
        target = 'Python-' + target

    command = command.replace('`', '\\`')
    command = command.replace('\'', '\"')
    command = command.replace('\"', '\"')

    pres = RakuCommand(command=''.join(["say ToDataQueryWorkflowCode('", command, "', '", target, "')"]),
                       moduleName='DSL::English::DataQueryWorkflows')

    if len(pres.stderr) > 0:
        print(pres.stderr)

    if execute:
        exec(pres.stdout, globals)

    return pres.stdout
