use std::fmt::{Display, Write};

#[derive(PartialEq, Debug)]
pub struct Clock {
    hours: u32,
    minutes: u32,
}

impl Clock {
    pub fn new(input_hour: i32, input_minute: i32) -> Self {
        let mut minutes = input_minute;
        let mut hours = input_hour;

        hours += minutes / 60;
        hours %= 24;

        minutes %= 60;

        if minutes < 0 {
            hours -= 1;
            minutes += 60;
        } 

        if hours < 0 { hours += 24 }

        Self {
            hours: hours as u32,
            minutes: minutes as u32,
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Self::new(self.hours as i32, self.minutes as i32 + minutes)
    }
}

impl Display for Clock {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_fmt(format_args!("{:02}:{:02}", self.hours, self.minutes))
    }
}
