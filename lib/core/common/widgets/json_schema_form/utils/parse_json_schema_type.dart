enum JsonSchemaType {
  object,
  string,
  integer,
  number,
  boolean,
  array,
  unknown,
}

JsonSchemaType parseJsonSchemaType(String? type) {
  switch (type) {
    case 'object':
      return JsonSchemaType.object;
    case 'string':
      return JsonSchemaType.string;
    case 'integer':
      return JsonSchemaType.integer;
    case 'number':
      return JsonSchemaType.number;
    case 'boolean':
      return JsonSchemaType.boolean;
    case 'array':
      return JsonSchemaType.array;
    default:
      return JsonSchemaType.unknown; // Handle unexpected values
  }
}
