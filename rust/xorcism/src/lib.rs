use std::{borrow::Borrow, io::{Read, Write}};

/// A munger which XORs a key with some data
#[derive(Clone)]
pub struct Xorcism<'a> {
    key: &'a [u8],
    cur: usize,
}

impl<'a> Xorcism<'a> {
    /// Create a new Xorcism munger from a key
    ///
    /// Should accept anything which has a cheap conversion to a byte slice.
    pub fn new<Key: ?Sized + AsRef<[u8]> + 'a>(key: &'a Key) -> Xorcism<'a> {
        Self {
            key: key.as_ref(),
            cur: 0,
        }
    }

    /// XOR each byte of the input buffer with a byte from the key.
    ///
    /// Note that this is stateful: repeated calls are likely to produce different results,
    /// even with identical inputs.
    pub fn munge_in_place(&mut self, data: &mut [u8]) {
        for data_val in data {
            *data_val ^= self.key[self.cur];
            self.cur += 1;
            self.cur %= self.key.len();
        }
    }

    /// XOR each byte of the data with a byte from the key.
    ///
    /// Note that this is stateful: repeated calls are likely to produce different results,
    /// even with identical inputs.
    ///
    /// Should accept anything which has a cheap conversion to a byte iterator.
    /// Shouldn't matter whether the byte iterator's values are owned or borrowed.
    pub fn munge<Data>(&'a mut self, data: Data) -> impl Iterator<Item = u8> + 'a
    where
        Data: IntoIterator + 'a,
        Data::Item: Borrow<u8>,
    {
        data.into_iter().map(|byte| {
            let xored = self.key[self.cur] ^ byte.borrow();
            self.cur += 1;
            self.cur %= self.key.len();
            xored
        })
    }

    pub fn reader(&self, reader: impl Read + 'a) -> XorReader<'a> {
        XorReader { munger: self.clone(), reader: Box::new(reader) }
    }
    pub fn writer(&self, writer: impl Write + 'a) -> XorWriter<'a> {
        XorWriter { munger: self.clone(), writer: Box::new(writer) }
    }
}

pub struct XorReader<'a> {
    munger: Xorcism<'a>,
    reader: Box<dyn Read + 'a>,
}

impl<'a> Read for XorReader<'a> {
    fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
        let res = self.reader.read(buf);
        self.munger.munge_in_place(buf);
        res
    }
}

pub struct XorWriter<'a> {
    munger: Xorcism<'a>,
    writer: Box<dyn Write + 'a>,
}

// impl<'a> Write for XorWriter<'a> {
//     fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
//         let munged_buf: Vec<u8> = self.munger.munge(buf).collect();
//         self.writer.write(munged_buf.as_slice())
//     }

//     fn flush(&mut self) -> std::io::Result<()> {
//         self.writer.flush()
//     }
// }
