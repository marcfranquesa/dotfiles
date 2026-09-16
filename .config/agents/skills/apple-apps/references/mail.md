# Mail

## Defaults

- Use the MIT email account for new outgoing messages unless a different account is specified.
- Reply from the account that received the message.
- Search all accounts unless the user narrows the scope.

## Usage

Scripting dictionary: `/System/Applications/Mail.app/Contents/Resources/Mail.sdef`.

- Reading does not authorize marking read, moving, or deleting messages.
- Draft when asked to draft; send only when authorized. Check recipients,
  sending account, attachments, and content before sending.
