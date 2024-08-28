#!/usr/bin/env node
import { createReadStream, createWriteStream } from 'fs';
import Papa from 'papaparse';
import { SparqlJsonParser } from 'sparqljson-parse';

const IN_JSON = process.argv[2];
const OUT_CSV = process.argv[3];

function resultsStreamToCsvStream(jsonStream, csvStream) {
  const parser = new SparqlJsonParser();
  const stream = parser.parseJsonResultsStream(jsonStream);

  return new Promise((resolve, _reject) => {
    let results = [];
    let unparseOptions;
    stream.on('variables', (variables) => {
      const header = variables.map((v) => v.value);
      unparseOptions = { header: false, columns: header };
      csvStream.write(Papa.unparse([header]) + '\n');
    });
    stream.on('data', (bindings) => {
      if (results.length > 0 && unparseOptions) {
        csvStream.write(Papa.unparse(results, unparseOptions) + '\n');
        results = [];
      }

      for (const key of Object.keys(bindings)) {
        bindings[key] = bindings[key]?.value ?? undefined;
      }

      if (unparseOptions) {
        csvStream.write(Papa.unparse([bindings], unparseOptions) + '\n');
      } else {
        results.push(bindings);
      }
    });
    stream.on('end', () => {
      if (unparseOptions && results.length > 0) {
        csvStream.write(Papa.unparse(results, unparseOptions) + '\n');
      }
      csvStream.close();
      resolve();
    });
  });
}

const inStream = IN_JSON === '-' ? process.stdin : createReadStream(IN_JSON, { flush: true, highWaterMark: 65536 });
const outStream = OUT_CSV === '-' ? process.stdout : createWriteStream(OUT_CSV, { flush: true, highWaterMark: 65536 });

await resultsStreamToCsvStream(inStream, outStream);
