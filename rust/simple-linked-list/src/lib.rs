#[derive(Debug)]
pub struct SimpleLinkedList<T> {
    value: Option<T>,
    next: Box<Option<SimpleLinkedList<T>>>,
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self {
            value: None, 
            next: Box::new(None)
        }
    }

    // You may be wondering why it's necessary to have is_empty()
    // when it can easily be determined from len().
    // It's good custom to have both because len() can be expensive for some types,
    // whereas is_empty() is almost always cheap.
    // (Also ask yourself whether len() is expensive for SimpleLinkedList)
    pub fn is_empty(&self) -> bool {
        self.next.is_none()
    }

    pub fn len(&self) -> usize {
        if let Some(next) = self.next.as_ref() {
            1 + next.len()
        } else {
            0
        }
    }

    pub fn push(&mut self, element: T) {
        if let Some(next) = self.next.as_mut() {
            next.push(element)
        } else {
            let mut next = Self::new();
            next.value = Some(element);
            self.next = Box::new(Some(next));
        }
    }

    pub fn pop(&mut self) -> Option<T> {
        if let Some(next) = self.next.as_mut() {
            if next.is_empty() {
                let val = next.value.take();
                self.next = Box::new(None);
                val
            } else {
                next.pop()
            }
        } else {
            let val = self.value.take();
            self.value = None;
            val
        }
    }

    pub fn peek(&self) -> Option<&T> {
        if let Some(next) = self.next.as_ref() {
            next.peek()
        } else {
            self.value.as_ref()
        }
    }

    #[must_use]
    pub fn rev(mut self) -> SimpleLinkedList<T> {
        if let Some(list) = self.next.take() {
            let mut list = list.rev();

            if let Some(val) = self.value {
                list.push(val);
            }

            list
        } else {
            self
        }
    }
}

impl<T> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        let mut list = Self::new();
        
        for i in iter {
            list.push(i)
        }

        list
    }
}

// In general, it would be preferable to implement IntoIterator for SimpleLinkedList<T>
// instead of implementing an explicit conversion to a vector. This is because, together,
// FromIterator and IntoIterator enable conversion between arbitrary collections.
// Given that implementation, converting to a vector is trivial:
//
// let vec: Vec<_> = simple_linked_list.into_iter().collect();
//
// The reason this exercise's API includes an explicit conversion to Vec<T> instead
// of IntoIterator is that implementing that interface is fairly complicated, and
// demands more of the student than we expect at this point in the track.

impl<T: std::fmt::Debug> From<SimpleLinkedList<T>> for Vec<T> {
    fn from(mut linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut output = Vec::new();

        if let Some(val) = linked_list.value {
            output.push(val);
        }

        while let Some(linked_list) = linked_list.next.take() {
            output.append(&mut linked_list.into())
        }

        output
    }
}
