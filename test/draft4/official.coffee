{draft4} = require "../../src/index"

suite = require "json-schema-tests"


#shell = require "shelljs"
#cmd = "node_modules/.bin/nserver -p 5725 -d test/JSON-Schema-Test-Suite/remotes"
#proc = shell.exec cmd, (code, output) ->
#
#Testify = require "testify"
#Testify.once "done", ->
  #console.log "Shutting down the 'remotes' test server"
  #proc.kill("SIGTERM")

[_node, _script, attribute, test_number] = process.argv

suite {
  attribute
  test_number

  version: "draft4"

  validate: (schema, document) ->
    v = new draft4(schema)
    v.validate(document)


  ignores:
    # Doubtful value for the majority of use cases.
    # https://github.com/pandastrike/jsck/issues/42
    minLength: [
      "one supplementary Unicode code point is not long enough"
    ]
    maxLength: [
      "two supplementary Unicode code points is long enough"
    ]

    # Not supported because of the potential performance implications
    # https://github.com/pandastrike/jsck/issues/2
    uniqueItems: true

    # Impossible to test when using output of JSON.parse
    # https://github.com/pandastrike/jsck/issues/6
    "optional/zeroTerminatedFloats": true
    
    # The following items require fetching of remote schemas.
    # Support for remote references is planned for the next version of JSCK
    refRemote: true
    ref: [
      "remote ref, containing refs itself"
    ]
    definitions: true
}
