import Papa from 'papaparse';
import { closeSync, openSync, writeSync } from 'node:fs';

const INPUT_JSON = process.argv[2];
const OUTPUT_CSV = process.argv[3];

async function* readLines(inputFile) {
  let inputStream = !inputFile || inputFile === '-' ? process.stdin : createReadStream(inputFile, { autoClose: true });
  if (inputFile?.endsWith('.gz')) {
    inputStream = inputStream.pipe(createGunzip());
  }
  const decoder = new TextDecoder('utf-8');
  let buffer = '';
  for await (const chunk of inputStream) {
    buffer += decoder.decode(chunk, { stream: true });
    let lines = buffer.split('\n');
    buffer = lines.pop();
    for (const line of lines) {
      yield line;
    }
  }
  if (buffer.length > 0) {
    yield buffer;
  }
}

function cleanSpaces(str) {
  return str?.replace(/\s+/g, ' ').trim() ?? '';
}

const results = openSync(OUTPUT_CSV, 'w');
writeSync(results, 'iri,id,name,aka,description\n');

for await (const line of readLines(INPUT_JSON)) {
  const obj = JSON.parse(line);
  const row = [ obj['@id'], obj.identifier, obj.name, '', obj.abstract ].map(cleanSpaces);
  writeSync(results, Papa.unparse([row]) + '\n');
}

closeSync(results);
