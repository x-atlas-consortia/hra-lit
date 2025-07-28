#!/usr/bin/env node
import { createReadStream, createWriteStream } from 'fs';
import Papa from 'papaparse';
import { stringToTerm } from 'rdf-string';

const IN_TSV = process.argv[2];
const OUT_CSV = process.argv[3];

function convertTerm(str) {
  const term = stringToTerm(str);
  switch (term.termType) {
    case 'NamedNode':
      return term.value.slice(1, -1);
    case 'Literal':
    default:
      return term.value;
  }
}

function resultsStreamToCsvStream(tsvStream, csvStream) {
  return new Promise((resolve, reject) => {
    let header;
    function parseRow(result) {
      if (!header) {
        header = result.data.map((s) => s.slice(1)); // remove ? from columns
        csvStream.write(Papa.unparse([header]) + '\n');
      } else {
        const row = result.data.map(convertTerm);
        csvStream.write(Papa.unparse([row]) + '\n');
      }
      if (result.errors.length > 0) {
        console.error('Errors parsing', result.errors);
        reject(result.errors);
      }
    }

    Papa.parse(tsvStream, { delimiter: '\t', quoteChar: '', escapeChar: '', step: parseRow, complete: resolve });
  });
}

const inStream = IN_TSV === '-' ? createReadStream('/dev/stdin') : createReadStream(IN_TSV);
const outStream = OUT_CSV === '-' ? createWriteStream('/dev/stdout') : createWriteStream(OUT_CSV);

await resultsStreamToCsvStream(inStream, outStream);
