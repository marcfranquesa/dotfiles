# Calendar

## Defaults

- Use the MIT calendar for new events unless the user specifies another calendar.

## Usage

Scripting dictionary: `/System/Applications/Calendar.app/Contents/Resources/iCal.sdef`.

- Discover calendars; identify targets by `calendarIdentifier` and event `uid`.
  Check `writable` before editing.
- Scope reads by date and calendar, including overlapping events. Simple date
  filters can miss recurring occurrences; verify these in the UI.
- Resolve time zones and all-day dates (exclusive end). For recurring edits,
  distinguish one occurrence from the series; use the UI when necessary.
- Adding guests or sending invitations requires authorization to communicate.
