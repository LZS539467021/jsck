{benchmark} = require "../validators"
benchmark {
  name: "Event"
  repeats: 256
  schema: require "./schema"
  valid_doc: require "./valid_doc"
}










